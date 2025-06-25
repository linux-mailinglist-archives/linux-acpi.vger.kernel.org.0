Return-Path: <linux-acpi+bounces-14626-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4D8AE8D1D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA8E4A2B06
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD132DAFD7;
	Wed, 25 Jun 2025 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gff5cji2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FBC1CAA7B;
	Wed, 25 Jun 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877769; cv=none; b=A8qBfwJ9GH0yFSBIf0ykcRfC1ft9hlHylkehLbvqA5ijbPVvUh92rvjtiFfzjtT60lvBYoO84HNrZ4MP5M4v/BWcrOJ3TbZURw4I/l9vzMJH+Zzk4EU+X8wbpmVyfyBSRmRpH6AW0Ky62OmeikrQ3BUF2oOhevPXhTq3zpadl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877769; c=relaxed/simple;
	bh=6xdnTIn9JsUPsSYNpRZM+JxKZeDZmlbySNAsX2t+WTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou7V+M4w+0VrpHIjlkb4ssZCRyusQ0qGztpBoSwhDiwKmDZ89aiXYbhEeUtXay1u1KSk4Qxbfrj71kJcvoXNHqquhzMWR8w1xfbd+61fVN/se8PULGkw36yMcvICNzvE5scT+GbjzX7SqXvZCeMKmNSw6M/4RaKNlUQo2T05lh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gff5cji2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338B7C4CEEA;
	Wed, 25 Jun 2025 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750877769;
	bh=6xdnTIn9JsUPsSYNpRZM+JxKZeDZmlbySNAsX2t+WTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gff5cji2w4rVgfmpej2qu34cYAMMr+BzZ4UHZaIH5XAbQTuM9i+g7mUq2U5j40fHZ
	 Z1q5bI29k3jsZWhuNj5yhDbG1Cf2CK2Ja0Ff7LDDsR3OOFfZ9Vzt2j15k/nXxeuZkT
	 9YjFuV7bOl1cksFgU80Bm0WScsAeKZPxiJYfl/Gw6Nw4fguHRhvgpQzb9a5DuxXi9k
	 r0a99nd/yLYW3OjYml4ONi/ceLO8lUzrdNYHwjtC2OmZGRegktJ+ySI9PYIagF4iS1
	 BZaw35eG2KRHrrYA05zBh06BuCSR5KKlQpVgpHHc3LUu/B0aN9NxM4wAvkXLn1IoOB
	 S80u/83hMdyFA==
Date: Wed, 25 Jun 2025 13:56:08 -0500
From: Rob Herring <robh@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 06/12] dt-bindings: usb: usb-device: Add orientation
 and rotation
Message-ID: <20250625185608.GA2010256-robh@kernel.org>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-6-5710f9d030aa@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-uvc-orientation-v2-6-5710f9d030aa@chromium.org>

On Thu, Jun 05, 2025 at 05:52:59PM +0000, Ricardo Ribalda wrote:
> For some devices, such as cameras, the OS needs to know where they are
> mounted.
> 
> ACPI has a property for this purpose, which is parsed by
> acpi_get_physical_device_location():
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#pld-physical-location-of-device
> 
> In DT we have similar properties for video-interface-devices called
> orientation and rotation:
> Documentation/devicetree/bindings/media/video-interface-devices.yaml
> 
> Add rotation and orientation for usb-devices that matches the already
> existing properties of video-interface-devices.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  Documentation/devicetree/bindings/usb/usb-device.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Comments from v1 still apply. Add a schema for *your* device (i.e. one 
that only matches the compatible string of your device). Look for 
anything that includes usb-device.yaml for an example. Your schema 
should have something like this if you want to use 
video-interface-devices.yaml properties:

allOf:
  - $ref: /schemas/usb/usb-device.yaml#
  - $ref: /schemas/media/video-interface-devices.yaml#

> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-device.yaml b/Documentation/devicetree/bindings/usb/usb-device.yaml
> index c676956810331b81f11f3624340fc3e612c98315..a44eb24c657993f88145377a4706ec419b6cd998 100644
> --- a/Documentation/devicetree/bindings/usb/usb-device.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-device.yaml
> @@ -44,6 +44,14 @@ properties:
>        - minimum: 1
>          maximum: 255
>  
> +  orientation:
> +    description: If present, specifies the orientation of the usb device.
> +    $ref: /schemas/media/video-interface-devices.yaml#/properties/orientation

Again, this is generally the wrong way to add properties from another 
schema for your device. Above is the right way.

Rob

