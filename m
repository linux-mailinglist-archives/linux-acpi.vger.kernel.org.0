Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74024D91E0
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Mar 2022 02:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbiCOBCT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 21:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiCOBCS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 21:02:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE4931911;
        Mon, 14 Mar 2022 18:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647306067; x=1678842067;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NWusIOIo+vyDfRBYbXa+JW6qvU98GxBj6Z5YtR9TtG0=;
  b=NlJjVTYHnBuGLse/ZPfYj2Zd799XgktYx4q4hv9lg7lW6k3PG5nZLqVG
   eXcU/UGAGoeonXZtDxhAqkdRwNADS3mOA22J5amppe4SS6RwaKhI84MGO
   SqVqyPdxJYV5lC541hpa4tQSDkOrf6sr3AcYtmnwndycC5/JGdWkdWxie
   /Or2zUhmIkoDpAKmQFSi4KrB6Mb3kzhbc4/QURqYA02wktseBmAUc+I7d
   98z/ysbVn0WouiBdwHs5YxYW4nGdCZHRLXe+Xmr0PgMlBcPH1VJONU9NK
   OnTT9ohC/95b3+QO+hmN9/7pns5OQ0FJs79ZwNGBFcMx/XzqH0MTWFMAo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="280949601"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="280949601"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:01:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="634413805"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Mar 2022 18:01:06 -0700
Received: from zehall-mobl.amr.corp.intel.com (unknown [10.209.53.245])
        by linux.intel.com (Postfix) with ESMTP id 9E357580690;
        Mon, 14 Mar 2022 18:01:06 -0700 (PDT)
Message-ID: <4121875ff3ee2999e50c687ed9f808d1dc98a68f.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>
Date:   Mon, 14 Mar 2022 18:01:06 -0700
In-Reply-To: <BL1PR12MB5157664C2AA7D80E7DF48EC9E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220314050340.1176-1-mario.limonciello@amd.com>
         <0101142d-3ea6-a47b-be26-76aaaac46b0a@redhat.com>
         <BL1PR12MB5157664C2AA7D80E7DF48EC9E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2022-03-14 at 13:32 +0000, Limonciello, Mario wrote:
> [Public]
> 
> > > +int acpi_register_lps0_callbacks(struct lps0_callback_handler *arg)
> > > +{
> > > +	struct lps0_callback_handler *handler;
> > > +
> > > +	if (!lps0_device_handle || sleep_no_lps0)
> > > +		return -ENODEV;
> > > +
> > > +	handler = kmalloc(sizeof(*handler), GFP_KERNEL);
> > > +	if (!handler)
> > > +		return -ENOMEM;
> > > +	handler->prepare_late_callback = arg->prepare_late_callback;
> > > +	handler->restore_early_callback = arg->restore_early_callback;
> > > +	handler->context = arg->context;
> > > +
> > > +	mutex_lock(&lps0_callback_handler_mutex);
> > > +	list_add(&handler->list_node, &lps0_callback_handler_head);
> > > +	mutex_unlock(&lps0_callback_handler_mutex);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);
> > 
> > Typically with calls like these we simply let the caller own the struct
> > lps0_callback_handler
> > and only make the list_add() call here. Typically the struct
> > lps0_callback_handler will
> > be embedded in the driver_data of the driver registering the handler and it
> > will
> > call the unregister function before free-ing its driver_data.
> > 
> 
> When I put this together I was modeling it off of `struct acpi_wakeup_handler`
> which the handling and the use in the kernel doesn't seem to follow the design
> pattern
> you describe.
> 
> Rafael - can you please confirm which direction you want to see here for this?
> 
> > > +
> > > +void acpi_unregister_lps0_callbacks(struct lps0_callback_handler *arg)
> > > +{
> > > +	struct lps0_callback_handler *handler;
> > > +
> > > +	mutex_lock(&lps0_callback_handler_mutex);
> > > +	list_for_each_entry(handler, &lps0_callback_handler_head,
> > list_node) {
> > > +		if (handler->prepare_late_callback == arg-
> > > prepare_late_callback &&
> > > +		    handler->restore_early_callback == arg-
> > > restore_early_callback &&
> > > +		    handler->context == arg->context) {
> > > +			list_del(&handler->list_node);
> > > +			kfree(handler);
> > > +			break;
> > > +		}
> > > +	}
> > > +	mutex_unlock(&lps0_callback_handler_mutex);
> > > +}
> > > +EXPORT_SYMBOL_GPL(acpi_unregister_lps0_callbacks);
> > 
> > And this then becomes just lock, list_del, unlock.
> > 
> > Regards,
> > 
> > Hans

If you keep v3,

Reviewed-by: David E. Box <david.e.box@linux.intel.com>

