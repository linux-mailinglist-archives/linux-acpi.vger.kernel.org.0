Return-Path: <linux-acpi+bounces-15667-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EBFB25C0B
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 08:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DE31C869F1
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 06:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D682561C2;
	Thu, 14 Aug 2025 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSwgMKHi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B622D4DE
	for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153707; cv=none; b=AEIVBEIVktTo1wHrCgkk4pNcZCJ7wktHgwPVRzNKEk03qIahDRKozOjf1u3iMobo54ij4yH/pNA9NlVoiE55N8hC0sLGFlZab1QMhhtEDy+idBw9cKvC38RwJ2xTvQ9pKollbqajuyMNQ1d9TwttOrbOTQbEnA9QTjjS3qEcFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153707; c=relaxed/simple;
	bh=GCbPMefnp9LdOOPenXhGV0oJ7QE490/uj4sFARHm2Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkg9a7JtWn1sxOVHkENL0dEX5FVA6CZ3FYMRTiAs40AWHh4Tt4TLq7QWr5HtpNKa1+WbZKKfnR4wk2QbaGMGFfgP5nz1TYRTYfA0RALb1DryzVNm54RCxFRR64iaeyzATUrbh0+EADL91BLXVUcEEBaQcVw7Hna7P5zwrlwKMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSwgMKHi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755153705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9gfDC3XT5JH5+UXZeFk4ANri2tI0Wf8QHIFMwTkbME=;
	b=HSwgMKHigl2T+QYoX2h/Z2DlKJ0+BmkKMdZfKJZiyC6BS/HW8jVRJ1l4Y/REkw1LQhVRZE
	hWj3ua3RuXXUansSxeqy5T/da8qwNs9cpXaDh2E3PWZ7lNVeyP5dC6Ae89sQG3VYckiUOU
	9sWygH9kaw9Ky7I09yH8Wv09sGczInA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-6PMqzjmxNtayLZkCCLxuLw-1; Thu, 14 Aug 2025 02:41:42 -0400
X-MC-Unique: 6PMqzjmxNtayLZkCCLxuLw-1
X-Mimecast-MFC-AGG-ID: 6PMqzjmxNtayLZkCCLxuLw_1755153701
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e4166a7bso315692f8f.2
        for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2025 23:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755153701; x=1755758501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9gfDC3XT5JH5+UXZeFk4ANri2tI0Wf8QHIFMwTkbME=;
        b=KwPWAiL9FmEGjmH9npHiwyezt17WAW/bC/Jnrwud8ea1gCoGU5Vsa0P2iPyB8bQKn2
         WPidvWg0HdoV9hc2p/3McCcmbrgANxHybGJVIJeAdhjFGPsDDHQio6HgRAwVGZzCCnSZ
         8vEi8tsNDsAoKYPlPgyfujLTLB5tFz2TV20Mr1sWwnFgcG9WDMjCtUV6ZeovEb05U1Wt
         9VqZia44mbqH1lSowdU8+TvT1HQpeui5DCa8lTyV2KMVhsY2FN6tDaIxxb6hzPw5QBtA
         boKq2dwwaFb9cXYVo1U8CX+nlmvhvT7LX5/i0taPHDjzGFleZfcVcIQPrQUV3qUvD9rZ
         zjoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz/4fgIW1pLTgoeGRbMgYiTpdjg5ITQGW09UlTsDeBEwduajJb+yG89iVUcU6GCTdlIx6a9F8Zhzx+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SgLjSeGW6k1O/Z2wf5QEN84pHOdUBwp5OtZTQwB4QHAjh9Xe
	9J3ligIyUzqJv81ZGjAen4qMJLv5hnQnGEhGBM7YO/UUa/R3gJ2dNla58Va8QOzfehPy/EwK3K9
	k/Ud72knAVUcnN1F5kxMKzxdxd7KVFAb2Kttw9diYif/hDV9Fy7cDA68fCXrtMSw=
X-Gm-Gg: ASbGncvA0igP3X4lJoJ+SrlFH0OPXesudwDdZsnnHMsNi4qA5JfzdmtJhQvZIz4EckD
	lTOCY+g1L+pa/ifVxw7HxZVuROlD67ov602tMDLyC11K4v1QPYGlPITe4I0a0j+5MkKYrUDQjI0
	msJZVQYC+iXrgqo/cKlx8yJa2k+uGnmuafjzb0C0C1sBBvp7Bc2FVvBE9D+jyi0YFGn5PEzKsld
	zYcZDvguRZgWvUzxuPOlc7vubKg2sdo1Q+o7rGbBb0JBHhzQnE6KBOKquW1i1pT89D5S4xd2coe
	FiJwUkCXlUN25upHt2W4kKLeEcTyMo4tEn8Ka+3jCVVsgS/wDD/PztDk2y2TA17miY3Iz8OrRnA
	2RBc=
X-Received: by 2002:a05:6000:40c7:b0:3b7:8a49:eed0 with SMTP id ffacd0b85a97d-3b9f1a13965mr1378456f8f.22.1755153701037;
        Wed, 13 Aug 2025 23:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpLaxNWs2oFsAZSrN9kqR+39ayEAZmpXcMUMLGDC+7HLlsr/ah//p96eCfa0Qd8T4sw00vYQ==
X-Received: by 2002:a05:6000:40c7:b0:3b7:8a49:eed0 with SMTP id ffacd0b85a97d-3b9f1a13965mr1378416f8f.22.1755153700568;
        Wed, 13 Aug 2025 23:41:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc932sm9252735e9.3.2025.08.13.23.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 23:41:39 -0700 (PDT)
Message-ID: <0f3a72c0-f52f-4ccc-acd8-861824fb762d@redhat.com>
Date: Thu, 14 Aug 2025 08:41:36 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] drm/panic: use `core::ffi::CStr` method names
To: Tamir Duberstein <tamird@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Javier Martinez Canillas <javierm@redhat.com>, Arnd Bergmann
 <arnd@arndb.de>, Len Brown <lenb@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
 <20250813-core-cstr-fanout-1-v3-1-545c14bc44ff@gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-1-545c14bc44ff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 17:41, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoid methods that only exist on the latter.

Thanks, it looks good to me.

Acked-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1075
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>   drivers/gpu/drm/drm_panic_qr.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index 09a9b452e8b7..10bc5bb16992 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -948,7 +948,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>           // nul-terminated string.
>           let url_cstr: &CStr = unsafe { CStr::from_char_ptr(url) };
>           let segments = &[
> -            &Segment::Binary(url_cstr.as_bytes()),
> +            &Segment::Binary(url_cstr.to_bytes()),
>               &Segment::Numeric(&data_slice[0..data_len]),
>           ];
>           match EncodedMsg::new(segments, tmp_slice) {
> 


