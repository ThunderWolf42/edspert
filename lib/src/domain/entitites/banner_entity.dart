class BannerEntity {
  final String imageUrl;
  final String redirectUrl;

  BannerEntity({
    required this.imageUrl,
    required this.redirectUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BannerEntity && other.imageUrl == imageUrl && other.redirectUrl == redirectUrl;
  }

  @override
  int get hashCode => imageUrl.hashCode ^ redirectUrl.hashCode;
}
