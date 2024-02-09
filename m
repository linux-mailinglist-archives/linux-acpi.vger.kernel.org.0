Return-Path: <linux-acpi+bounces-3315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1A384F435
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Feb 2024 12:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC2B1C21CBE
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Feb 2024 11:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729A025619;
	Fri,  9 Feb 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AyAfloOg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259D2E3E5
	for <linux-acpi@vger.kernel.org>; Fri,  9 Feb 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476847; cv=none; b=p5ZsWxlJFigWW8iPYBMC6Iivd4MT1qlwfbuge2wHmFN6qrLlIFAzdbKJ+QSAPVZjDO9pnxvdnhP5CyopLS0x0Gxdg72dr1f8yfwgS5tft+lA8kM0swVOcqhp8gbczIsSFvOCyB5N2akpw0G+5Hjk7iaCCXMiykjzVpw1okxCi+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476847; c=relaxed/simple;
	bh=OkfsW9z2svfOcyu/w+waoySATTEy3sngJ7BDVvj4UVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBFZsW+C/+mjJ13d5kiYGSYhZrefoJT7Q03s7tRO4cTB6pcPkK99SagQg/XIFqXG2CFBkVB8Y1wXZ7wqQXQ5HIDw+kORdWkZL85NZRSW/FL16uYpaUdLOcWZuGzWlQJIeu96vF3kf9PAgSz7udnnqT5BXy2Q2W1CkiziAsCCD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=AyAfloOg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fb17fd179so1926595e9.0
        for <linux-acpi@vger.kernel.org>; Fri, 09 Feb 2024 03:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707476844; x=1708081644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhrnFyHqy0aS26mIHqOzAL9BsMYc94FViF7OPHFoQ/w=;
        b=AyAfloOgTUDyK+L/B6GcBgeKCWQRIvuiVrCWoTuR22NVX5ZRbLwwgCwACVeTKypzpi
         +llLB6RNbBpQ59PTtB7DoqyXTwcfCvssTY9C89C6dgdwv0n9c1VgJR6qYvSQmL31QSOg
         NUwHkqiM6FoJiP7AYua151OqHKc3lEKjFsw2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476844; x=1708081644;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhrnFyHqy0aS26mIHqOzAL9BsMYc94FViF7OPHFoQ/w=;
        b=BMFFwCtvwqMIb8HOx9efu3XwzNovKNTHRzZEj+DVfQPueVIuBAKEwNw46idGIk3UXv
         H3WCgLWbdPeSWfnj2wPIKWxeF5e4H2gCxNj4HzWKVyBbMqwbORb3fb2uUgluXHd98jjg
         Mn8bLm7TMymGQNgqTUWkikLuglV78lMVRkgtj5nCdzb4FyQtwwm/y4VRFJfeIYpo9ZEu
         V1u5xCPAiiuLG8zvet9BOAtd5bDzTcu6+oxHWrOfgiSSvrCEXSbWrAT+qILszJZRJ7ak
         VKf5MJVIQDsfVCg3EeCY/SAgFf82Rv6y9scfgXmoyrPiSAdEZ3UPcm9w3a/RDdEj3G1L
         uWCA==
X-Forwarded-Encrypted: i=1; AJvYcCX9OAyqy4mDdTFm9+Rf70FTO0YCVH8Rh7wg+b+/82xHYeITo1rYjecorA4GU4Ia7mGqCc22dTdmkACe0bxvvoAomIgiz3Wp4Tp6GA==
X-Gm-Message-State: AOJu0YzqCAhpNbuuWSG2av4sC2RWXl80nJTeehAUNZaXzOWi6+mkiVqF
	qDEXi16bSNECkYTKdagEZU77pu69QyHF+kYXk66wB0DvoXS4pbI2W/6oiCFz8N0=
X-Google-Smtp-Source: AGHT+IESgQ/XoK3SRZmBXi3b5ikWdz6eVncuVf3cEnstSnjQCV9N/vFouYd2MVwTobjhl48ECI9Ilg==
X-Received: by 2002:adf:e188:0:b0:33b:52cf:ebd5 with SMTP id az8-20020adfe188000000b0033b52cfebd5mr761452wrb.5.1707476843780;
        Fri, 09 Feb 2024 03:07:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtdkordPphCgqyMB+BMAQXrG4CC6BqVcmdmOVeCn/Jn3saUScdVw2KpMv2L9QB9xybAk7EVtRBzqt88YHwPeIRMGdmauy71GqDYAOr80StpMlaw1Ah5p8GY9jA12cnZ/aa6dcwZbJ4NeX/kLY3FuRSNakzQv8cRw1Kg2R/R7VUQOGxpWNmW51Y+DC8aph7B55k2cuYvGO7bzLIFrDtXb3e7Jq9Xra2VTghe8WKHD6mPnG0FuFdnzjZ5D3bEYby11xF8eWCi/0Gc3zgXne2XpRuUGByEXiomn91j7vh7zaLhTyfkbZptNAz71BOn3yYBAmSx372jzuttcbC7nfszh0KNGNPjBprbIl+0tWrvgHlhUButRr5Ri4HExZLRvwkx6JaNm2w9rW7kqrOQ8WzDd5mCw==
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o15-20020adfeacf000000b0033b5a6b4b9bsm1520956wrn.71.2024.02.09.03.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 03:07:23 -0800 (PST)
Date: Fri, 9 Feb 2024 12:07:21 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	amd-gfx@lists.freedesktop.org,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Melissa Wen <mwen@igalia.com>, Dave Airlie <airlied@redhat.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v4 1/3] drm: Add drm_get_acpi_edid() helper
Message-ID: <ZcYHaXNJ8IqbLIra@phenom.ffwll.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	amd-gfx@lists.freedesktop.org,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Melissa Wen <mwen@igalia.com>, Dave Airlie <airlied@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20240207224429.104625-1-mario.limonciello@amd.com>
 <20240207224429.104625-2-mario.limonciello@amd.com>
 <87y1bvb7ns.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1bvb7ns.fsf@intel.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Thu, Feb 08, 2024 at 11:57:11AM +0200, Jani Nikula wrote:
> On Wed, 07 Feb 2024, Mario Limonciello <mario.limonciello@amd.com> wrote:
> > Some manufacturers have intentionally put an EDID that differs from
> > the EDID on the internal panel on laptops.  Drivers can call this
> > helper to attempt to fetch the EDID from the BIOS's ACPI _DDC method.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/gpu/drm/Kconfig    |  5 +++
> >  drivers/gpu/drm/drm_edid.c | 77 ++++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_edid.h     |  1 +
> >  3 files changed, 83 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 6ec33d36f3a4..ec2bb71e8b36 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -21,6 +21,11 @@ menuconfig DRM
> >  	select KCMP
> >  	select VIDEO_CMDLINE
> >  	select VIDEO_NOMODESET
> > +	select ACPI_VIDEO if ACPI
> > +	select BACKLIGHT_CLASS_DEVICE if ACPI
> > +	select INPUT if ACPI
> > +	select X86_PLATFORM_DEVICES if ACPI && X86
> > +	select ACPI_WMI if ACPI && X86
> 
> I think I'll defer to drm maintainers on whether this is okay or
> something to be avoided.

Uh yeah this is a bit much, and select just messes with everything. Just
#ifdef this in the code with a dummy alternative, if users configure their
kernel without acpi but need it, they get to keep all the pieces.

Alternatively make a DRM_ACPI_HELPERS symbol, but imo a Kconfig for every
function is also not great. And just using #ifdef in the code also works
for CONFIG_OF, which is exactly the same thing for platforms using dt to
describe hw.

Also I'd expect ACPI code to already provide dummy functions if ACPI is
provided, so you probably dont even need all that much #ifdef in the code.

What we defo cant do is select platform/hw stuff just because you enable
CONFIG_DRM.
-Sima

> 
> 
> >  	help
> >  	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
> >  	  introduced in XFree86 4.0. If you say Y here, you need to select
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index 923c4423151c..c649b4f9fd8e 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -28,6 +28,7 @@
> >   * DEALINGS IN THE SOFTWARE.
> >   */
> >  
> > +#include <acpi/video.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/cec.h>
> >  #include <linux/hdmi.h>
> > @@ -2188,6 +2189,49 @@ drm_do_probe_ddc_edid(void *data, u8 *buf, unsigned int block, size_t len)
> >  	return ret == xfers ? 0 : -1;
> >  }
> >  
> > +/**
> > + * drm_do_probe_acpi_edid() - get EDID information via ACPI _DDC
> > + * @data: struct drm_device
> > + * @buf: EDID data buffer to be filled
> > + * @block: 128 byte EDID block to start fetching from
> > + * @len: EDID data buffer length to fetch
> > + *
> > + * Try to fetch EDID information by calling acpi_video_get_edid() function.
> > + *
> > + * Return: 0 on success or error code on failure.
> > + */
> > +static int
> > +drm_do_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
> > +{
> > +	struct drm_device *ddev = data;
> > +	struct acpi_device *acpidev = ACPI_COMPANION(ddev->dev);
> > +	unsigned char start = block * EDID_LENGTH;
> > +	void *edid;
> > +	int r;
> > +
> > +	if (!acpidev)
> > +		return -ENODEV;
> > +
> > +	/* fetch the entire edid from BIOS */
> > +	r = acpi_video_get_edid(acpidev, ACPI_VIDEO_DISPLAY_LCD, -1, &edid);
> > +	if (r < 0) {
> > +		DRM_DEBUG_KMS("Failed to get EDID from ACPI: %d\n", r);
> > +		return -EINVAL;
> > +	}
> > +	if (len > r || start > r || start + len > r) {
> > +		r = -EINVAL;
> > +		goto cleanup;
> > +	}
> > +
> > +	memcpy(buf, edid + start, len);
> > +	r = 0;
> > +
> > +cleanup:
> > +	kfree(edid);
> > +
> > +	return r;
> > +}
> > +
> >  static void connector_bad_edid(struct drm_connector *connector,
> >  			       const struct edid *edid, int num_blocks)
> >  {
> > @@ -2643,6 +2687,39 @@ struct edid *drm_get_edid(struct drm_connector *connector,
> >  }
> >  EXPORT_SYMBOL(drm_get_edid);
> >  
> > +/**
> > + * drm_get_acpi_edid - get EDID data, if available
> 
> I'd prefer all the new EDID API to be named drm_edid_*. Makes a clean
> break from the old API, and is more consistent.
> 
> So perhaps drm_edid_read_acpi() to be in line with all the other struct
> drm_edid based EDID reading functions.
> 
> > + * @connector: connector we're probing
> > + *
> > + * Use the BIOS to attempt to grab EDID data if possible.
> > + *
> > + * The returned pointer must be freed using drm_edid_free().
> > + *
> > + * Return: Pointer to valid EDID or NULL if we couldn't find any.
> > + */
> > +const struct drm_edid *drm_get_acpi_edid(struct drm_connector *connector)
> > +{
> > +	const struct drm_edid *drm_edid;
> > +
> > +	switch (connector->connector_type) {
> > +	case DRM_MODE_CONNECTOR_LVDS:
> > +	case DRM_MODE_CONNECTOR_eDP:
> > +		break;
> > +	default:
> > +		return NULL;
> > +	}
> > +
> > +	if (connector->force == DRM_FORCE_OFF)
> > +		return NULL;
> > +
> > +	drm_edid = drm_edid_read_custom(connector, drm_do_probe_acpi_edid, connector->dev);
> > +
> > +	/* Note: Do *not* call connector updates here. */
> > +
> > +	return drm_edid;
> > +}
> > +EXPORT_SYMBOL(drm_get_acpi_edid);
> > +
> >  /**
> >   * drm_edid_read_custom - Read EDID data using given EDID block read function
> >   * @connector: Connector to use
> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> > index 7923bc00dc7a..ca41be289fc6 100644
> > --- a/include/drm/drm_edid.h
> > +++ b/include/drm/drm_edid.h
> > @@ -410,6 +410,7 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
> >  	void *data);
> >  struct edid *drm_get_edid(struct drm_connector *connector,
> >  			  struct i2c_adapter *adapter);
> > +const struct drm_edid *drm_get_acpi_edid(struct drm_connector *connector);
> 
> There's a comment
> 
> /* Interface based on struct drm_edid */
> 
> towards the end of the file, gathering all the new API under it.
> 
> Other than that, LGTM,
> 
> BR,
> Jani.
> 
> >  u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
> >  struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
> >  				     struct i2c_adapter *adapter);
> 
> -- 
> Jani Nikula, Intel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

