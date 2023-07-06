Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED6749A50
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 13:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjGFLM2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 07:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGFLM2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 07:12:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0147FDC;
        Thu,  6 Jul 2023 04:12:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-160-25-222.reb.o2.cz [85.160.25.222])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 389627F3;
        Thu,  6 Jul 2023 13:11:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1688641899;
        bh=OWagwHyt/VmUMEoVxdOhm7IiAVbsqJkK+yfLGk8d+oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gi6HFjo7tLapJ+IwAwcgzuPRsrADFi6z2G/H6ICe86BFQmGEJ/Xa+TMNX6ShO2Nmk
         IbqUbOTOmiJWHO355gcBhqcd46MYelIbGFsAiMmtuYJco47+z4CnnycoHM+jLqz/Xd
         dDZY/mxidxgFEL28lYFkCOaJJM7eBB5yUriqeSc8=
Date:   Thu, 6 Jul 2023 14:12:24 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 17/18] media: atomisp: csi2-bridge: Add dev_name() to
 acpi_handle_info() logging
Message-ID: <20230706111224.GA20921@pendragon.ideasonboard.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-18-hdegoede@redhat.com>
 <ZKaS2UbkbkbfYqAe@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKaS2UbkbkbfYqAe@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 06, 2023 at 01:09:29PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 05, 2023 at 11:30:09PM +0200, Hans de Goede wrote:
> > acpi_handle_info() uses the ACPI path to the handle as prefix for messages
> > e.g. : "\_SB_.I2C2.CAM8".
> > 
> > This makes it hard for users to figure out which csi2-bridge messages
> > belong to which sensor since the actual sensor drivers uses the ACPI
> > device name (typically "HID:00") for logging.
> > 
> > Extend the acpi_handle_info() (and err and warn) logging to also log
> > the device name to make it easier to match csi2-bridge messages with
> > sensor driver log messages.
> 
> Fine by me, one suggestion below (up to you, guys)
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> > Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  .../media/atomisp/pci/atomisp_csi2_bridge.c   | 51 ++++++++++++-------
> >  1 file changed, 34 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c b/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
> > index 551c6fd244fd..8124be486e2e 100644
> > --- a/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
> > +++ b/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
> > @@ -131,7 +131,8 @@ static char *gmin_cfg_get_dsm(struct acpi_device *adev, const char *key)
> >  			if (!val)
> >  				break;
> >  
> > -			acpi_handle_info(adev->handle, "Using DSM entry %s=%s\n", key, val);
> > +			acpi_handle_info(adev->handle, "%s: Using DSM entry %s=%s\n",
> > +					 dev_name(&adev->dev), key, val);
> 
> Maybe (maybe!) it's a candidate to have something like
> 
> v4l2_acpi_log_info(adev, ...) which combines both and unloads the code from
> thinking about it?

Or acpi_dev_info() that would take an acpi_device pointer. Or just just
dev_info(&adev->dev) ?

> >  			break;
> >  		}
> >  	}
> > @@ -156,7 +157,8 @@ static char *gmin_cfg_get_dmi_override(struct acpi_device *adev, const char *key
> >  		if (strcmp(key, gv->key))
> >  			continue;
> >  
> > -		acpi_handle_info(adev->handle, "Using DMI entry %s=%s\n", key, gv->val);
> > +		acpi_handle_info(adev->handle, "%s: Using DMI entry %s=%s\n",
> > +				 dev_name(&adev->dev), key, gv->val);
> >  		return kstrdup(gv->val, GFP_KERNEL);
> >  	}
> >  
> > @@ -192,7 +194,8 @@ static int gmin_cfg_get_int(struct acpi_device *adev, const char *key, int defau
> >  	return int_val;
> >  
> >  out_use_default:
> > -	acpi_handle_info(adev->handle, "Using default %s=%d\n", key, default_val);
> > +	acpi_handle_info(adev->handle, "%s: Using default %s=%d\n",
> > +			 dev_name(&adev->dev), key, default_val);
> >  	return default_val;
> >  }
> >  
> > @@ -235,7 +238,8 @@ static int atomisp_csi2_get_pmc_clk_nr_from_acpi_pr0(struct acpi_device *adev)
> >  	ACPI_FREE(buffer.pointer);
> >  
> >  	if (ret < 0)
> > -		acpi_handle_warn(adev->handle, "Could not find PMC clk in _PR0\n");
> > +		acpi_handle_warn(adev->handle, "%s: Could not find PMC clk in _PR0\n",
> > +				 dev_name(&adev->dev));
> >  
> >  	return ret;
> >  }
> > @@ -254,7 +258,8 @@ static int atomisp_csi2_set_pmc_clk_freq(struct acpi_device *adev, int clock_num
> >  	clk = clk_get(NULL, name);
> >  	if (IS_ERR(clk)) {
> >  		ret = PTR_ERR(clk);
> > -		acpi_handle_err(adev->handle, "Error getting clk %s:%d\n", name, ret);
> > +		acpi_handle_err(adev->handle, "%s: Error getting clk %s: %d\n",
> > +				dev_name(&adev->dev), name, ret);
> >  		return ret;
> >  	}
> >  
> > @@ -268,7 +273,8 @@ static int atomisp_csi2_set_pmc_clk_freq(struct acpi_device *adev, int clock_num
> >  	if (!ret)
> >  		ret = clk_set_rate(clk, PMC_CLK_RATE_19_2MHZ);
> >  	if (ret)
> > -		acpi_handle_err(adev->handle, "Error setting clk-rate for %s:%d\n", name, ret);
> > +		acpi_handle_err(adev->handle, "%s: Error setting clk-rate for %s: %d\n",
> > +				dev_name(&adev->dev), name, ret);
> >  
> >  	clk_put(clk);
> >  	return ret;
> > @@ -317,7 +323,8 @@ static int atomisp_csi2_handle_acpi_gpio_res(struct acpi_resource *ares, void *_
> >  
> >  	if (i == data->settings_count) {
> >  		acpi_handle_warn(data->adev->handle,
> > -				 "Could not find DSM GPIO settings for pin %u\n", pin);
> > +				 "%s: Could not find DSM GPIO settings for pin %u\n",
> > +				 dev_name(&data->adev->dev), pin);
> >  		return 1;
> >  	}
> >  
> > @@ -329,7 +336,8 @@ static int atomisp_csi2_handle_acpi_gpio_res(struct acpi_resource *ares, void *_
> >  		name = "powerdown-gpios";
> >  		break;
> >  	default:
> > -		acpi_handle_warn(data->adev->handle, "Unknown GPIO type 0x%02lx for pin %u\n",
> > +		acpi_handle_warn(data->adev->handle, "%s: Unknown GPIO type 0x%02lx for pin %u\n",
> > +				 dev_name(&data->adev->dev),
> >  				 INTEL_GPIO_DSM_TYPE(settings), pin);
> >  		return 1;
> >  	}
> > @@ -354,7 +362,8 @@ static int atomisp_csi2_handle_acpi_gpio_res(struct acpi_resource *ares, void *_
> >  	data->map->mapping[i].size = 1;
> >  	data->map_count++;
> >  
> > -	acpi_handle_info(data->adev->handle, "%s crs %d %s pin %u active-%s\n", name,
> > +	acpi_handle_info(data->adev->handle, "%s: %s crs %d %s pin %u active-%s\n",
> > +			 dev_name(&data->adev->dev), name,
> >  			 data->res_count - 1, agpio->resource_source.string_ptr,
> >  			 pin, active_low ? "low" : "high");
> >  
> > @@ -391,7 +400,8 @@ static int atomisp_csi2_add_gpio_mappings(struct acpi_device *adev)
> >  	obj = acpi_evaluate_dsm_typed(adev->handle, &intel_sensor_module_guid,
> >  				      0x00, 1, NULL, ACPI_TYPE_STRING);
> >  	if (obj) {
> > -		acpi_handle_info(adev->handle, "Sensor module id: '%s'\n", obj->string.pointer);
> > +		acpi_handle_info(adev->handle, "%s: Sensor module id: '%s'\n",
> > +				 dev_name(&adev->dev), obj->string.pointer);
> >  		ACPI_FREE(obj);
> >  	}
> >  
> > @@ -405,7 +415,8 @@ static int atomisp_csi2_add_gpio_mappings(struct acpi_device *adev)
> >  				      &intel_sensor_gpio_info_guid, 0x00, 1,
> >  				      NULL, ACPI_TYPE_INTEGER);
> >  	if (!obj) {
> > -		acpi_handle_err(adev->handle, "No _DSM entry for GPIO pin count\n");
> > +		acpi_handle_err(adev->handle, "%s: No _DSM entry for GPIO pin count\n",
> > +				dev_name(&adev->dev));
> >  		return -EIO;
> >  	}
> >  
> > @@ -413,7 +424,9 @@ static int atomisp_csi2_add_gpio_mappings(struct acpi_device *adev)
> >  	ACPI_FREE(obj);
> >  
> >  	if (data.settings_count > CSI2_MAX_ACPI_GPIOS) {
> > -		acpi_handle_err(adev->handle, "Too many GPIOs %u > %u\n", data.settings_count, CSI2_MAX_ACPI_GPIOS);
> > +		acpi_handle_err(adev->handle, "%s: Too many GPIOs %u > %u\n",
> > +				dev_name(&adev->dev), data.settings_count,
> > +				CSI2_MAX_ACPI_GPIOS);
> >  		return -EOVERFLOW;
> >  	}
> >  
> > @@ -427,7 +440,8 @@ static int atomisp_csi2_add_gpio_mappings(struct acpi_device *adev)
> >  					      0x00, i + 2,
> >  					      NULL, ACPI_TYPE_INTEGER);
> >  		if (!obj) {
> > -			acpi_handle_err(adev->handle, "No _DSM entry for pin %u\n", i);
> > +			acpi_handle_err(adev->handle, "%s: No _DSM entry for pin %u\n",
> > +					dev_name(&adev->dev), i);
> >  			return -EIO;
> >  		}
> >  
> > @@ -442,7 +456,8 @@ static int atomisp_csi2_add_gpio_mappings(struct acpi_device *adev)
> >  			    INTEL_GPIO_DSM_PIN(data.settings[j]))
> >  				continue;
> >  
> > -			acpi_handle_err(adev->handle, "Duplicate pin number %lu\n",
> > +			acpi_handle_err(adev->handle, "%s: Duplicate pin number %lu\n",
> > +					dev_name(&adev->dev),
> >  					INTEL_GPIO_DSM_PIN(data.settings[i]));
> >  			return -EIO;
> >  		}
> > @@ -463,12 +478,14 @@ static int atomisp_csi2_add_gpio_mappings(struct acpi_device *adev)
> >  
> >  	if (data.map_count != data.settings_count ||
> >  	    data.res_count != data.settings_count)
> > -		acpi_handle_warn(adev->handle, "ACPI GPIO resources vs DSM GPIO-info count mismatch (dsm: %d res: %d map %d\n",
> > -				 data.settings_count, data.res_count, data.map_count);
> > +		acpi_handle_warn(adev->handle, "%s: ACPI GPIO resources vs DSM GPIO-info count mismatch (dsm: %d res: %d map %d\n",
> > +				 dev_name(&adev->dev), data.settings_count,
> > +				 data.res_count, data.map_count);
> >  
> >  	ret = acpi_dev_add_driver_gpios(adev, data.map->mapping);
> >  	if (ret)
> > -		acpi_handle_err(adev->handle, "Error adding driver GPIOs: %d\n", ret);
> > +		acpi_handle_err(adev->handle, "%s: Error adding driver GPIOs: %d\n",
> > +				dev_name(&adev->dev), ret);
> >  
> >  	return ret;
> >  }

-- 
Regards,

Laurent Pinchart
