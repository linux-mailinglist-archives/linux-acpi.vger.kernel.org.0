Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB377784EBC
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Aug 2023 04:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjHWCal (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Aug 2023 22:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjHWCak (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Aug 2023 22:30:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E300FB;
        Tue, 22 Aug 2023 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692757838; x=1724293838;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=OPu3hUsbSk7LIlJO5L+UISIgru5ydxSRCk1NaX/6Jbg=;
  b=KJN8WFZPvzjC1i3m4ovfPLGALU1ObTEGUm69mgTY1vppOPOO+9RJ6pKX
   f2arFdC917W102gzJpDa0O0R9hHPd3fgQYl9VZm3GFgkDPCIjBiSB0e0C
   4EsEeQuBzoHMme1IYQuY8OyADPlEWTxQf523ycoP3i/fOyKPMqshXfDe4
   wFzbTtZz7FRtAmz3H1GHpJ4TQehTnQwwEeM9dQia4fAv7N/YlW7N8j28S
   jeF6y23Eh5LP9v993Qc+/lur8TR7fnZdhsNlwxOulqu4Sf5Buz26MElDL
   81TtAe2jgy4SN0PhOGcajn6hkzFlAtbfiWn1NGVNcY/JXb/mLe9+bV6o2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="374018595"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="374018595"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 19:30:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="686261338"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="686261338"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 19:30:33 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Jrn Engel <joern@purestorage.com>
Cc:     Uday Shankar <ushankar@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Len Brown <len.brown@intel.com>,
        linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH] Revert "ACPI, APEI, use raw spinlock in ERST"
References: <20230822010933.2247671-1-ushankar@purestorage.com>
        <87y1i3c015.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZOQodU1CNMRtjYZ6@cork>
Date:   Wed, 23 Aug 2023 10:28:28 +0800
In-Reply-To: <ZOQodU1CNMRtjYZ6@cork> (J.'s message of "Mon, 21 Aug 2023
        20:16:05 -0700")
Message-ID: <87h6oqbigj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jrn Engel <joern@purestorage.com> writes:

> On Tue, Aug 22, 2023 at 09:56:38AM +0800, Huang, Ying wrote:
>> 
>> ERST is mainly used to log the hardware error.  While, hardware error
>> may be reported via NMI (e.g., ACPI APEI GHES NMI), so we need to call
>> ERST functions in NMI handlers.  Where normal spinlock cannot be used
>> because they will be converted to sleepable rt_mutex in RT kernel.
>
> Non-sleeping spinlocks cannot be used in NMI context either.
> raw_spin_lock_irqsave() will prevent regular interrupts, but not NMI.
> So taking a spinlock inside an NMI can trigger a deadlock.

Thanks reminding from Uday, trylock can avoid the deadlock.  More
details in reply to Uday's email.

--
Best Regards,
Huang, Ying

> Am I missing something here?
>
> Jrn
>
> --
> All art is but imitation of nature.
> -- Lucius Annaeus Seneca
