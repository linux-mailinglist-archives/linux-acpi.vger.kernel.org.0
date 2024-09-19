Return-Path: <linux-acpi+bounces-8344-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF7597C817
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331031F28F88
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D1019C572;
	Thu, 19 Sep 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4klQt6x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3119A28B
	for <linux-acpi@vger.kernel.org>; Thu, 19 Sep 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742427; cv=none; b=me/KpOZWgATuAOSgKssJntVn56Tjtr/RDPfNySDvVjLO0sp4SLvoRQTu2iIlL7/bHpzMWKbBeoUhOuHeQEx4vRqXlinZybC1P48KPr4OQeMBX0rods//t4KKl8gq4Id5rvyKJ5qjM2ovw0Mww7b+iPki4fjAdNy8pvpiLBZz7qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742427; c=relaxed/simple;
	bh=qoDUajQehGlYjPE+EFxWKCbmqWSP7/qcihd+c2Gym3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwKo4rQaVdpZoySmL+8OJUJbfO66z1CLaAcddRZYJKDOEl9gtocsYiLU8208QYDPv3mknDJ7DL4oVyd4ClId/VEDbZiFpRLyOhrW7SDGRyDBKsg54wKkgR6poFBBfnfv2NsWzwvc67SCZCzRFBY8BVdpE2HxUq0f3iGhl1CscoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u4klQt6x; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5365d3f9d34so707714e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 19 Sep 2024 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726742423; x=1727347223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tlp0Vtf+ppPpgYrefgR4cL8ADFuvH9H5/WfU6RLRJKw=;
        b=u4klQt6xDQLGRXdh06UIIZPpqXuJt5MVaUBTerXhaZuAhXBsa/zbncbtvEMxedZbxj
         w3t3KKoRlaBzkOxaOn+Yeq7i3SF1z9aQvGsJfVsb6ruMFLG7hKDwq64Gs4H7OUI7/n7h
         TP6zJ0+T2eZm3EV4FsXbaBStFmRS5MLQFTqXL9/xpiyvZsBlZCIvENlAtVLqVUQSHSeB
         wOX1cHT9jWaBwklWHQcwiJMjN7qRZxDzIRS5SJEZ1Umi9djOf1W34rXyFxJGVwCHnaDU
         DL+FbjzVBOA2gpVar8xIiTQWAD/6URNQxihyuZnIGKnvYJpgqgjC4yRqLlz1i1fhs7H4
         Dhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726742423; x=1727347223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tlp0Vtf+ppPpgYrefgR4cL8ADFuvH9H5/WfU6RLRJKw=;
        b=tHblumcW5hoAPIli/4ifHCQhCrYUQVjqF4+pQf1ZrRDOKpJkON2O0Ir/5wnILGyKP/
         bJR2G4t11b6DpUkwr08Ph0iCkBMEvUdjDcask+evlHZf77w7+H+53x8UueyuSm4G8NOD
         fwVguCoHuEmVwHhtBKI50LpZp7ADIn9OHwC31axvi6sWYnbGWGK54EACSMvoBPloxBsa
         cfsSA6EIhX+mRTyGrHzjEpzoOjndRo8+YT5YFTxBJUIUj1R2Nx9zHsmXu8ieEXzt2pe9
         ddITBjDnalf8uhi0U8dIZA20sTMBJEFDYWJJp9HeJErRjCjzk3Cq4t67VGSNfK+Ab15F
         iCEg==
X-Forwarded-Encrypted: i=1; AJvYcCUXKb6azWhQpxRXJuZMg1Z+dnIlNgvuFBxaRvnOnHR95xNIBey8wPQ0OwDNGyAzgV4LRZRwGZkErr0+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyte+nA6YAZakNhcMapO+kOoVkhAxZ0D9eqxwPODJ+uWAnyooht
	knj7x0LdhOMt7LBo9aYBVwVTGGqhpCp9n6UHQjlxF/CKY7BONybiv4I3j+N6E1A=
X-Google-Smtp-Source: AGHT+IFsBfQFVXZbIJ+oDVW1NrcdVcEb6a89r2YZcMp056f8arAvyaJffZux2dBaqfrkRNgZ76BvOw==
X-Received: by 2002:a05:6512:3d87:b0:535:82eb:21d1 with SMTP id 2adb3069b0e04-5367ff329d7mr11826771e87.57.1726742422532;
        Thu, 19 Sep 2024 03:40:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870b421esm1839803e87.254.2024.09.19.03.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 03:40:20 -0700 (PDT)
Date: Thu, 19 Sep 2024 13:40:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	Guenter Roeck <groeck@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: [PATCH v4 13/18] dt-bindings: usb-switch: Extend for DisplayPort
 altmode
Message-ID: <27acewh6h2xcwp63z5o3tgrjmimf4d3mftpnmkvhdhv273zgsp@i6i5ke4btdqx>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-14-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901040658.157425-14-swboyd@chromium.org>

On Sat, Aug 31, 2024 at 09:06:51PM GMT, Stephen Boyd wrote:
> Extend the usb-switch binding to support DisplayPort (DP) alternate
> modes. A third port for the DP signal is necessary when a mode-switch is
> muxing USB and DP together onto a usb type-c connector. Add data-lanes
> to the usbc output node to allow a device using this binding to remap
> the data lanes on the output. Add an example to show how this new port
> can be used.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../devicetree/bindings/usb/usb-switch.yaml   | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-switch.yaml b/Documentation/devicetree/bindings/usb/usb-switch.yaml
> index f5dc7e23b134..816f295f322f 100644
> --- a/Documentation/devicetree/bindings/usb/usb-switch.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-switch.yaml
> @@ -52,6 +52,14 @@ properties:
>            endpoint:
>              $ref: '#/$defs/usbc-in-endpoint'
>  
> +      port@2:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +
> +        properties:
> +          endpoint:
> +            $ref: '#/$defs/dp-endpoint'

Is it a separate port or is it an endpoint of the same upstream-facing
(non-connector-facing) SS port?

> +
>  oneOf:
>    - required:
>        - port
> @@ -65,6 +73,19 @@ $defs:
>      $ref: /schemas/graph.yaml#/$defs/endpoint-base
>      description: Super Speed (SS) output endpoint to a type-c connector
>      unevaluatedProperties: false
> +    properties:
> +      data-lanes:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: |
> +          An array of physical USB Type-C data lane indexes.
> +          - 0 is SSRX1 lane
> +          - 1 is SSTX1 lane
> +          - 2 is SSTX2 lane
> +          - 3 is SSRX2 lane
> +        minItems: 4
> +        maxItems: 4
> +        items:
> +          maximum: 3

What is the usecase to delare less than 4 lanes going to the USB-C
connector?

>  
>    usbc-in-endpoint:
>      $ref: /schemas/graph.yaml#/$defs/endpoint-base
> @@ -79,7 +100,75 @@ $defs:
>          items:
>            maximum: 8
>  
> +  dp-endpoint:
> +    $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +    description: DisplayPort (DP) input from the DP PHY
> +    unevaluatedProperties: false
> +    properties:
> +      data-lanes:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: |
> +          An array of physical DP data lane indexes
> +          - 0 is DP ML0 lane
> +          - 1 is DP ML1 lane
> +          - 2 is DP ML2 lane
> +          - 3 is DP ML3 lane
> +        oneOf:
> +          - items:
> +              - const: 0
> +              - const: 1
> +          - items:
> +              - const: 0
> +              - const: 1
> +              - const: 2
> +              - const: 3
> +
>  examples:
> +  # A USB + DP mode and orientation switch which muxes DP altmode
> +  # and USB onto a usb-c-connector node.
> +  - |
> +    device {
> +      mode-switch;
> +      orientation-switch;
> +
> +      ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {
> +          reg = <0>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          endpoint {
> +            remote-endpoint = <&usb_c_connector>;
> +            data-lanes = <0 1 2 3>;
> +          };
> +        };
> +
> +        port@1 {
> +          reg = <1>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          endpoint {
> +            remote-endpoint = <&usb_ss_phy>;
> +          };
> +        };
> +
> +        port@2 {
> +          reg = <2>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          endpoint {
> +            remote-endpoint = <&dp_phy>;
> +            data-lanes = <0 1 2 3>;
> +          };
> +        };
> +      };
> +    };
> +
>    # A USB orientation switch which flips the pin orientation
>    # for a usb-c-connector node.
>    - |
> -- 
> https://chromeos.dev
> 

-- 
With best wishes
Dmitry

