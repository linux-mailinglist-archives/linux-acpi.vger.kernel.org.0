Return-Path: <linux-acpi+bounces-1007-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F11C7D7814
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 00:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3651B20FE4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5211037CBC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+lT0VXA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82A34182
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:33:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498F5D6;
	Wed, 25 Oct 2023 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698266026; x=1729802026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Elh1JXJLo3TVoGeHHdFgceAsuCm69jUSI3BArgC3C3w=;
  b=A+lT0VXA4IrTj2RnkoG/sLutYnOw3mVNpxHlZdFzwGRyqh/iFRKEhXn2
   IHd66Nf52jbOuILxQ0GcJqGnoxesURneF7dr3IkEEAdZ/r5/kLyLI8Xhr
   OmxCJeqoOLW6LunG1FE6MRJX0DL+Jq39lr+Yo1ORbxMhrocObF9ik3a+V
   TiUA7V5tIKD36yI9q2k83b0u6NGCKGSsz3opOkSBZi2oXzAvl0S/Jw2XM
   kqH4KKxDV8TSQL/eeVjc74wSR1osYlSQ8DXvFpxrPcJlTTmD+1q5CW+uF
   3lmA5Hjm6Mm9ly5zNhK+Du3nb3vWb4ZT89TEE3O0bWrCszAiASig72S+r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="8949463"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="8949463"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="762578874"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762578874"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:33:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qvkZR-00000008gFE-0oOY;
	Wed, 25 Oct 2023 23:33:41 +0300
Date: Wed, 25 Oct 2023 23:33:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, mika.westerberg@linux.intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZTl7pDRypS3ZDIMy@smile.fi.intel.com>
References: <20231025053833.16014-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025053833.16014-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 25, 2023 at 11:08:33AM +0530, Raag Jadav wrote:
> Use acpi_dev_uid_match() for matching _UID instead of treating it
> as an integer.

NAK. See below why.

...

>  static void byt_pwm_setup(struct lpss_private_data *pdata)
>  {
> -	u64 uid;
> -
>  	/* Only call pwm_add_table for the first PWM controller */
> -	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
> +	if (!acpi_dev_uid_match(pdata->adev, "1"))

_UID by specification is a type of _string_. Yet, that string may represent an
integer number. Now, how many variants of the strings can you imagine that may
be interpreted as integer 1? I can tell about dozens.

With your change you restricted the all possible spectre of the 1
representations to a single one. Have you checked ALL of the DSDTs
for these platforms to say 'hey, all current tables uses "1" and
this is not an issue'? Further question, will you guarantee that new
platforms on this chip won't use something different? (Not that big
issue, but will require to actively revert your change in the future).

>  		return;
>  
>  	pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
> @@ -218,10 +216,8 @@ static struct pwm_lookup bsw_pwm_lookup[] = {
>  
>  static void bsw_pwm_setup(struct lpss_private_data *pdata)
>  {
> -	u64 uid;
> -
>  	/* Only call pwm_add_table for the first PWM controller */
> -	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
> +	if (!acpi_dev_uid_match(pdata->adev, "1"))
>  		return;

-- 
With Best Regards,
Andy Shevchenko



