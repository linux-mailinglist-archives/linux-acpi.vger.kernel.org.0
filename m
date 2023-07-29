Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E367681FE
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jul 2023 23:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjG2VoR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 29 Jul 2023 17:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjG2VoQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Jul 2023 17:44:16 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF7819A1;
        Sat, 29 Jul 2023 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690667055; x=1722203055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hM6zWlN0D1S10NPl/dsmryRdSy/yWlThW59MOIN5onY=;
  b=m2PE+a9rN9RmruVpg0KsK8r9DLkmVMy0fMtZ/3133hv1jI4T2+3Ut9SG
   TVF4roxornbeyF1vtKJTZOquD16ahv2z2v9rOxtF4ELIuV0ot/zfeTm/R
   tt7R6jdRVFr+1VBUhBt/gBjtB8yLUW0uHam3/Tw+NZoZWGMcuqP3zWAF8
   lNanWEx2KLbBN3HtSOzFN5KYK/wPQLlGLr1VltO2uw8UZdsqnnoaIFbvl
   IJWGv5aYhBFz76qBDL8Yxf99Bt26hZkk9mqvhB5LPc0sTG622lZBy9dr8
   Gk73khWFRGDSka/98INZx922rxjAzOfhWiNkg4iAhUM8Ed6NUX+FjeeyW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="358823578"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="358823578"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 14:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="721628819"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="721628819"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 14:44:12 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 7729511F863;
        Sun, 30 Jul 2023 00:44:09 +0300 (EEST)
Date:   Sat, 29 Jul 2023 21:44:09 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Wentong Wu <wentong.wu@intel.com>, rafael@kernel.org
Cc:     hdegoede@redhat.com, djrscally@gmail.com,
        laurent.pinchart@ideasonboard.com, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, bingbu.cao@linux.intel.com,
        zhifeng.wang@intel.com, xiang.ye@intel.com, tian.shu.qiu@intel.com
Subject: Re: [PATCH v10 3/3] ACPI: delay enumeration of devices with a _DEP
 pointing to IVSC device
Message-ID: <ZMWIKTAuHqHZ3+dc@kekkonen.localdomain>
References: <1690631575-15124-1-git-send-email-wentong.wu@intel.com>
 <1690631575-15124-4-git-send-email-wentong.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690631575-15124-4-git-send-email-wentong.wu@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Sat, Jul 29, 2023 at 07:52:55PM +0800, Wentong Wu wrote:
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 2743444..59c92a9 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -796,6 +796,9 @@ static const char * const acpi_ignore_dep_ids[] = {
>  /* List of HIDs for which we honor deps of matching ACPI devs, when checking _DEP lists. */
>  static const char * const acpi_honor_dep_ids[] = {
>  	"INT3472", /* Camera sensor PMIC / clk and regulator info */
> +	"INTC1059", /* IVSC (TGL) driver must be loaded to allow i2c access to camera sensors */
> +	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
> +	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
>  	NULL
>  };
>  

Could this patch be merged via the ACPI tree? There's no direct dependency
to the two other patches in the set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus
