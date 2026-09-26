shader_type canvas_item;

// 플레이어의 화면 중심 좌표 (0.0 ~ 1.0)
uniform vec2 player_position = vec2(0.5, 0.5);
// 원의 크기 반지름 (1.0이면 화면을 덮고, 0.0이면 완전히 닫힘)
uniform float circle_size : hint_range(0.0, 1.05) = 1.05;
// 화면 종횡비 수정 (원이 타원으로 찌그러지는 것 방지)
uniform float screen_ratio = 1.7778; 

void fragment() {
    // UV 좌표를 중심점으로 이동 및 종횡비 보정
    vec2 uv = UV - player_position;
    uv.x *= screen_ratio;
    
    // 플레이어 중심으로부터의 거리 계산
    float dist = length(uv);
    
    // 거리가 반지름(circle_size)보다 크면 검은색, 작으면 투명(Mask)
    // smoothstep을 사용해 원의 경계를 부드럽게 처리합니다.
    float alpha = smoothstep(circle_size, circle_size + 0.02, dist);
    
    // 기존 검은색 바탕에 알파값 적용
    COLOR = vec4(COLOR.rgb, alpha);
}
