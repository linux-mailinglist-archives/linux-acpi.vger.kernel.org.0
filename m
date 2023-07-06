Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61974992D
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 12:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGFKQR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 06:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGFKP6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 06:15:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4F919B7;
        Thu,  6 Jul 2023 03:15:57 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363597392"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="363597392"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 03:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="832892049"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="832892049"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2023 03:15:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qHM1g-000UWU-2w;
        Thu, 06 Jul 2023 13:15:52 +0300
Date:   Thu, 6 Jul 2023 13:15:52 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 18/18] media: atomisp: csi2-bridge: Add support for
 VCM I2C-client instantiation
Message-ID: <ZKaUWAAf586ZIRMF@smile.fi.intel.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-19-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705213010.390849-19-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 05, 2023 at 11:30:10PM +0200, Hans de Goede wrote:
> Fill sensor->vcm_type and call intel_cio2_bridge_instantiate_vcm() from
> the v4l2-async bound op so that an I2C-client will be instatiated for
> the VCM.
> 
> Note unfortunately on atomisp the _DSM to get the VCM type sometimes
> returns a VCM even though there is none. Since VCMs are typically only
> used together with certain sensors, work around this by adding a vcm
> field to atomisp_sensor_config and only check for a VCM when that is set.

...

> +static char *atomisp_csi2_get_vcm_type(struct acpi_device *adev)
> +{
> +	union acpi_object *obj;
> +	char *vcm_type;
> +
> +	obj = acpi_evaluate_dsm_typed(adev->handle, &vcm_dsm_guid, 0, 0,
> +				      NULL, ACPI_TYPE_STRING);
> +	if (!obj)
> +		return NULL;
> +
> +	vcm_type = kstrdup(obj->string.pointer, GFP_KERNEL);

Where is the counterpart kfree()?

> +	ACPI_FREE(obj);
> +
> +	if (!vcm_type)
> +		return NULL;
> +
> +	string_lower(vcm_type, vcm_type);
> +	return vcm_type;
> +}

-- 
With Best Regards,
Andy Shevchenko


