Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50602784ECC
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Aug 2023 04:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjHWCkg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Aug 2023 22:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjHWCke (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Aug 2023 22:40:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77D3E47;
        Tue, 22 Aug 2023 19:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692758432; x=1724294432;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=Jrs5IR8T2AU/DWG0HVl8d8t4VzZHKEjNOhMu/aCsJC8=;
  b=a+RgMZhIHh9ESSlhv08JWncsWSee91r2Hz27pvbW39HfuUmpfwyRwrsT
   7bAvwcKcvOCM/QNBeJAZVrdySJTZHQYxDKi3iZ12y8g0COVC8r2havUWl
   eQ8gA324k8nuCG/QDgZ6SXMFdK21lmrxtrW+Rusf0wY9hmB+H7RJzAWBX
   LPnVlbNpTTGnz7W4flhXRTHFd0lp6diOLm01CUsl404gkhVBhRz/TDq2t
   qRT0g4VGqX4I8r7FUmdhWzpauFHgwPBqoFmbRRjNAFMNPICI8OoUsvEjl
   ufDmvyD/8OLawYZ6pmvbJRo/FlVP0m3NRqVTDsR00ThiI4t0j4D+WJfdp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="354376084"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="354376084"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 19:40:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="860155343"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="860155343"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 19:40:28 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Uday Shankar <ushankar@purestorage.com>
Cc:     =?utf-8?Q?J=C3=B6rn?= Engel <joern@purestorage.com>,
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
        <20230822234522.GA2590891@dev-ushankar.dev.purestorage.com>
Date:   Wed, 23 Aug 2023 10:38:23 +0800
In-Reply-To: <20230822234522.GA2590891@dev-ushankar.dev.purestorage.com> (Uday
        Shankar's message of "Tue, 22 Aug 2023 17:45:22 -0600")
Message-ID: <87cyzebi00.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Uday Shankar <ushankar@purestorage.com> writes:

> On Mon, Aug 21, 2023 at 08:16:05PM -0700, J=C3=B6rn Engel wrote:
>> On Tue, Aug 22, 2023 at 09:56:38AM +0800, Huang, Ying wrote:
>> >=20
>> > ERST is mainly used to log the hardware error.  While, hardware error
>> > may be reported via NMI (e.g., ACPI APEI GHES NMI), so we need to call
>> > ERST functions in NMI handlers.  Where normal spinlock cannot be used
>> > because they will be converted to sleepable rt_mutex in RT kernel.
>>=20
>> Non-sleeping spinlocks cannot be used in NMI context either.
>> raw_spin_lock_irqsave() will prevent regular interrupts, but not NMI.
>> So taking a spinlock inside an NMI can trigger a deadlock.
>>=20
>> Am I missing something here?
>>=20
>> J=C3=B6rn
>>=20
>> --
>> All art is but imitation of nature.
>> -- Lucius Annaeus Seneca
>
> Also want to point out that both before and after this commit, we only
> use trylock from erst_write, which looks like the only function touched
> by this patch which can be called from NMI context. Trylock should be
> safe in NMI context regardless of the type of synchronization used
> (raw_spinlock, spinlock, or otherwise).

Thanks for reminding!  That's a good point.

Checked the implementation of rt_mutex version of spin_trylock().  One
possible code path is,

spin_trylock()
  rt_spin_trylock()
    __rt_spin_trylock()
      rt_mutex_slowtrylock()
        raw_spin_lock_irqsave()

IIUC, the deadlock is still possible for rt_mutex.  While it seems that
the deadlock isn't possible for raw_spinlock.  If so, it's still better
to use raw_spinlock.

--
Best Regards,
Huang, Ying
