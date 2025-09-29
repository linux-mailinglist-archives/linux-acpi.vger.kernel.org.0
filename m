Return-Path: <linux-acpi+bounces-17388-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB99BA865E
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 10:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577EE17039C
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 08:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CBD1F582C;
	Mon, 29 Sep 2025 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IpXqMdPh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735571F130B
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134653; cv=none; b=VWLOs7QbtAXLoaoBrTxujyFmUO1GrwZIjJQJEZHNjSUDaIdv47fucxtpNqARxW8vYYN0kWPVYWdBupTOZlHDH9PLTJ8tmBhsS8iyXvSqI1Cuao+8nu5lBz3wV5zr1vNtiA6mnxabAGMhPZPRJ/vIuIvVbDsDon4PmtI1PGDOCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134653; c=relaxed/simple;
	bh=1yWrEi955nPPvBu1m9KwQaY5HyLcEXUxbZckZNeDmWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKOfVQpACF2/q6nhAMdqIq9ObcHtSmH1DT5/V7MzeymDiDSXfC/4ymNV5oFOi3ym1Wl9a4vb5xmIvCAA3SNClossuQP8kLGuMTGV52MH1bLjANKCzu59c9kAWhgxThBsapA+Ta3QZSnz5zU6My8xFSGmIjidjHtwVOztbd1e39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IpXqMdPh; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57d93a4b5e5so5024150e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759134649; x=1759739449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UJONDUXJa/G+AY4kgKaGSYPSvsqZ+MAfDWA2lmXRRpc=;
        b=IpXqMdPho9g6CT24o5ZwTclNZciefBRbPeuJYlYGsGM0zMrolwEGdMMBNpkIeY5Cmr
         jiL14FFLtOZbSrums49rO0jTa5tovzbezmPVQPFsRlnzI286KopVySdyDXjcug/HpTV5
         YQ2iFwnqyGDI6FsogC4476jbaBgshaY1vrc8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759134649; x=1759739449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJONDUXJa/G+AY4kgKaGSYPSvsqZ+MAfDWA2lmXRRpc=;
        b=nnwRp1kjjF5ZJIlirgZQeI86d8LuN49wsDEYfVFFw953GIDfOd1nNYKJbLlLZLcE7t
         yQJDc8HWjdgOOkytTqEDBDt1ZqM4fBu4UZYkaQliDgM6PKh56VO0BRtGsomTLZX0hinS
         o/4FFzduNHtoqWj5+gyaW2hDLs8wuJ5U0Z9z4AGLGTERKtchzml9Fjl147rQdWjHTxvM
         OB8JEWLofUDFwX1qCE3NI/ApkpEqtaerfPh6t82xEbPkRWyLrwfeFkxam3+ARifr1JM5
         YLaogs1+YNUB4Gr3g4IQOZ+y5s2EL5j2bkPsWJTVtGYO6py92VBvb0kli9YkkRz2z8X6
         islQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVafyRtNevoUrKq1tOX1xvlGgzubdU3ohu5n1b3RLNId8A+ZtqBaok35DaG88RM3RQszfAL/x+0zOj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Kp9vTxj+xA4NislJLW0C3h05i9QL4SHTz7WDtiGyZlvctRln
	lCNad5dZe+N0JQYOElbfxtU9cnse5LCJnS4uA+hCANZHrxBJjuArhNM+ym16Hhv3kqvxPrZYc4L
	DcJQ=
X-Gm-Gg: ASbGnct3x3pGCAbMBgYRgQhneoIuevw8myq6uBofPiCk1JF+LiojGhZjHBqLr0M1U95
	LS7rs2dVhscVtcRT/Rpwzn4WDPyyMk8oLMSZnYiK1CAEad/YNtt+71Mo5wgKJfg02KTiwoqotpk
	n0AcuZey/iFDE9LBDRLAMk8rl7kQsIc/RLn4v9Qrst/54F/UKaAWexiTEOXLC0pdopNgC8XWoB+
	IWWK56IZJQLioJQ7t4iLNviUFRp7X7BVgdEk+eygBthkLT6tWGk6P3bFmPIJCC1w67NEXuf+9c5
	0a2hTDOxL4RtsaLSE7Azx/WMK/0JwyHNRj1ZBGi7OY7MzZQj5H8xsTz/UO5SJEjUfDTmlh1KKCH
	vx0f5AWdhoBihQk5wYLokYMr7QtocTTdx53TsHUdE9bNuRtOhdVDmsO3pRXm+
X-Google-Smtp-Source: AGHT+IEBCfVHNUTUIcprqzAmRgov3ymWoV+6wbPsq+UU+TH8gABbq6rYK9ZVhhdhAd7+rhiQuA36UA==
X-Received: by 2002:a05:651c:1989:b0:36c:ebb0:821c with SMTP id 38308e7fff4ca-36f7d2c5070mr58712111fa.7.1759134649437;
        Mon, 29 Sep 2025 01:30:49 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb0eb4a90sm26128811fa.0.2025.09.29.01.30.48
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 01:30:48 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57b35e176dbso5484619e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 01:30:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrnNm43481o0Pm62us+AS1rOorbENduu25wScSOaS2F0M4P/oYShsb3otZm4mEzwahnGPpYp2XUt20@vger.kernel.org
X-Received: by 2002:a05:6512:1102:b0:57c:2474:3740 with SMTP id
 2adb3069b0e04-582d3f76e30mr4820322e87.46.1759134647732; Mon, 29 Sep 2025
 01:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
 <20250926-uvc-orientation-v3-7-6dc2fa5b4220@chromium.org> <20250926-mute-boil-e75839753526@spud>
In-Reply-To: <20250926-mute-boil-e75839753526@spud>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Sep 2025 10:30:35 +0200
X-Gmail-Original-Message-ID: <CANiDSCuddqjeDr80xKsZZP7CXu9qB5qqYPoZujNYLcVjK0kKkg@mail.gmail.com>
X-Gm-Features: AS18NWDuABHOrlsFlY-rDCN1sMikoapkz5ecsd4Y1lKthbQuEsgF6GxQRq0htYQ
Message-ID: <CANiDSCuddqjeDr80xKsZZP7CXu9qB5qqYPoZujNYLcVjK0kKkg@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] dt-bindings: media: Add usb-camera-module
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Hans Verkuil <hverkuil@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Conor

On Fri, 26 Sept 2025 at 18:55, Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Sep 26, 2025 at 01:11:31PM +0000, Ricardo Ribalda wrote:
> > For fixed cameras modules the OS needs to know where they are mounted.
> > This information is used to determine if images need to be rotated or
> > not.
> >
> > ACPI has a property for this purpose, which is parsed by
> > acpi_get_physical_device_location():
> > https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#pld-physical-location-of-device
> >
> > In DT we have similar properties for video-interface-devices called
> > orientation and rotation:
> > Documentation/devicetree/bindings/media/video-interface-devices.yaml
> >
> > Add a new schema that combines usb/usb-device.yaml and
> > media/video-interface-devices.yaml
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  .../bindings/media/usb-camera-module.yaml          | 46 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/usb-camera-module.yaml b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..e4ad6f557b9151751522e49b72ae6584deb0c7ba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/usb-camera-module.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: USB Camera Module
> > +
> > +maintainers:
> > +  - Ricardo Ribalda <ribalda@chromium.org>
> > +
> > +description: |
> > +  This schema allows for annotating auxiliary information for fixed camera
> > +  modules. This information enables the system to determine if incoming frames
> > +  require rotation, mirroring, or other transformations. It also describes the
> > +  module's relationship with other hardware elements, such as flash LEDs or
> > +  Voice Coil Motors (VCMs).
> > +
> > +allOf:
> > +  - $ref: /schemas/usb/usb-device.yaml#
> > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > +
> > +properties:
> > +  reg:
> > +    maxItems: 1
> > +
>
> What actually causes this schema to be applied? Did I miss it getting
> included somewhere?

I guess your question is why I have not defined the compatible field?

I tried this change[1] with no luck:
/usr/local/google/home/ribalda/work/linux/Documentation/devicetree/bindings/media/uvc-camera.example.dtb:
device@1 (uvc-camera): compatible: ['uvc-camera'] does not contain
items matching the given schema

I think it failed, because If we add these allOfs as Rob proposed
https://lore.kernel.org/all/20250625185608.GA2010256-robh@kernel.org/:
```
allOf:
  - $ref: /schemas/usb/usb-device.yaml#
  - $ref: /schemas/media/video-interface-devices.yaml#
```
We cannot (or I do not know how to) have a different compatible than
the one from usb-device.yaml


Any suggestion on how to do this properly will be highly appreciated :)

Thanks!



[1]

@@ -21,10 +21,14 @@ allOf:
   - $ref: /schemas/media/video-interface-devices.yaml#

 properties:
+  compatible:
+    const: uvc-camera
+
   reg:
     maxItems: 1

 required:
+  - compatible
   - reg

 additionalProperties: true
@@ -38,8 +42,8 @@ examples:
         #size-cells = <0>;

         device@1 {
-            compatible = "usb123,4567";
+           compatible = "uvc-camera";
             reg = <2>;
             orientation = <0>;
             rotation = <90>;
         };

>
> > +required:
> > +  - reg
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    usb@11270000 {
> > +        reg = <0x11270000 0x1000>;
> > +        interrupts = <0x0 0x4e 0x0>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        device@1 {
> > +            compatible = "usb123,4567";
> > +            reg = <2>;
> > +            orientation = <0>;
> > +            rotation = <90>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ee8cb2db483f6a5e96b62b6f2edd05b1427b69f5..1503502a3aed2625e8ff488456ccd7305cc74ba7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -26258,6 +26258,7 @@ L:    linux-media@vger.kernel.org
> >  S:   Maintained
> >  W:   http://www.ideasonboard.org/uvc/
> >  T:   git git://linuxtv.org/media.git
> > +F:   Documentation/devicetree/bindings/media/usb-camera-module.yaml
> >  F:   Documentation/userspace-api/media/drivers/uvcvideo.rst
> >  F:   Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
> >  F:   Documentation/userspace-api/media/v4l/metafmt-uvc.rst
> >
> > --
> > 2.51.0.536.g15c5d4f767-goog
> >



--
Ricardo Ribalda

