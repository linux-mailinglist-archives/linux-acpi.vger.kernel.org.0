Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA72C7203EC
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbjFBOBq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 10:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjFBOBp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 10:01:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4676318C;
        Fri,  2 Jun 2023 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685714504; x=1717250504;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=62eUZ1WgHKhSaV7KBcN4DmVlf2R9NpAJelqA4VAOaew=;
  b=DP9nbPRU/3jz73OeCzXgeXPH4gCgl3NWU887JDpshwCR3JlI5pCG621B
   4yz6suQAF1hGoqFFJNGAh7GlOzrxQuuCiuCGuAA7oxFd3pnzSpe5+hwzy
   QAG5f00VJCF1/6sWYAmOZcuOgFyQAkjbKp25ehdJRkahlDFCJ2VRPrrSA
   HihAkwc3E3UdctALlxWgN3zyltFRB+DhcOK/NvzWTYqeK1NzWo8nwq4GV
   +L8Rhs6nfxl6IYjXm4iifQixD0DXdCXpMR/sI9N1MvnsQhnf18fBAF5x9
   sxIR3reqQbT4MIt4iP5SLNE5VuwJeE/VegYy12N565Sbhck/HPtMHzP4L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="421687912"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="421687912"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="701973651"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="701973651"
Received: from rspatil-mobl3.gar.corp.intel.com ([10.251.208.112])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:01:41 -0700
Date:   Fri, 2 Jun 2023 17:01:38 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
cc:     =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH v4 19/35] platform/x86/dell/dell-rbtn: Move handler
 installing logic to driver
In-Reply-To: <d7e2577e-b6c3-a392-4331-5ff16e68a609@intel.com>
Message-ID: <55b4cc-22c-42c7-ec38-3985d724c84@linux.intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com> <20230601131739.300760-20-michal.wilczynski@intel.com> <ba90f648-6f29-57f3-b1cc-91b929fda393@linux.intel.com> <d7e2577e-b6c3-a392-4331-5ff16e68a609@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-593855215-1685714503=:1742"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-593855215-1685714503=:1742
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 2 Jun 2023, Wilczynski, Michal wrote:
> On 6/2/2023 3:20 PM, Ilpo Järvinen wrote:
> > On Thu, 1 Jun 2023, Michal Wilczynski wrote:
> >
> >> Currently logic for installing notifications from ACPI devices is
> >> implemented using notify callback in struct acpi_driver. Preparations
> >> are being made to replace acpi_driver with more generic struct
> >> platform_driver, which doesn't contain notify callback. Furthermore
> >> as of now handlers are being called indirectly through
> >> acpi_notify_device(), which decreases performance.
> >>
> >> Call acpi_device_install_event_handler() at the end of .add() callback.
> >> Call acpi_device_remove_event_handler() at the beginning of .remove()
> >> callback. Change arguments passed to the notify callback to match with
> >> what's required by acpi_device_install_event_handler().
> >>
> >> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >> ---
> >>  drivers/platform/x86/dell/dell-rbtn.c | 17 ++++++++++++-----
> >>  1 file changed, 12 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
> >> index aa0e6c907494..4dcad59eb035 100644
> >> --- a/drivers/platform/x86/dell/dell-rbtn.c
> >> +++ b/drivers/platform/x86/dell/dell-rbtn.c
> >> @@ -207,7 +207,7 @@ static void rbtn_input_event(struct rbtn_data *rbtn_data)
> >>  
> >>  static int rbtn_add(struct acpi_device *device);
> >>  static void rbtn_remove(struct acpi_device *device);
> >> -static void rbtn_notify(struct acpi_device *device, u32 event);
> >> +static void rbtn_notify(acpi_handle handle, u32 event, void *data);
> >>  
> >>  static const struct acpi_device_id rbtn_ids[] = {
> >>  	{ "DELRBTN", 0 },
> >> @@ -293,7 +293,6 @@ static struct acpi_driver rbtn_driver = {
> >>  	.ops = {
> >>  		.add = rbtn_add,
> >>  		.remove = rbtn_remove,
> >> -		.notify = rbtn_notify,
> >>  	},
> >>  	.owner = THIS_MODULE,
> >>  };
> >> @@ -422,7 +421,10 @@ static int rbtn_add(struct acpi_device *device)
> >>  		ret = -EINVAL;
> >>  	}
> >>  
> >> -	return ret;
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
> > What about the other things that are done in rbtn_remove(), should you 
> > rollback more?
> 
> Yeah you're right, but the total lack of rollback in .add() here seems 
> to be an issue on it's own i.e even before this patchset .add() was 
> leaking resources in case of failure.
> I wonder whether to add missing rollback in separate commit ?

Yes, make separate patch out of it and mark it with Fixes tag. You can 
send it separately.

> > I suspect there's a pre-existing lack of rbtn_acquire(device, false); 
> > here to begin with.
> >
> 

-- 
 i.

--8323329-593855215-1685714503=:1742--
