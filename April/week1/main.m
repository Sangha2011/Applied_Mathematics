clear; clc; close all;

num_points = 10;
points = rand(num_points, 2);

figure; hold on;
axis([0 1 0 1]);
axis equal;
grid on;

N = size(points,1);

for i = 1:N
    
    region = [0 0; 1 0; 1 1; 0 1];
    
    for j = 1:N
        if i == j
            continue;
        end
        
        p = points(i,:);
        q = points(j,:);
        
        mid = (p + q) / 2;

        normal = q - p;

        new_region = [];
        n = size(region,1);
        
        for k = 1:n
            A = region(k,:);
            B = region(mod(k,n)+1,:);
            
            da = dot(A - mid, normal);
            db = dot(B - mid, normal);
            
            if da <= 0
                new_region = [new_region; A];
            end
            
            if da * db < 0
                t = da / (da - db);
                intersection = A + t * (B - A);
                new_region = [new_region; intersection];
            end
        end
        
        region = new_region;
        
        if isempty(region)
            break;
        end
    end
    
    if ~isempty(region)
        fill(region(:,1), region(:,2), rand(1,3), 'FaceAlpha', 0.4);
    end
end

plot(points(:,1), points(:,2), 'ko', 'MarkerFaceColor','k');

title('Voronoi Diagram by 2026수학응용동아리');
xlabel('X');
ylabel('Y');

hold off;