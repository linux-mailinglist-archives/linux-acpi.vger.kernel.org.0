Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11FD7812D5
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Aug 2023 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356488AbjHRSYJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Aug 2023 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379439AbjHRSYF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2023 14:24:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334A82D58
        for <linux-acpi@vger.kernel.org>; Fri, 18 Aug 2023 11:24:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0A4D2188D;
        Fri, 18 Aug 2023 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692383042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SX+D2sM86o3QGpOyvkgvl+QwlBYRKQsPyzgbZzO4nyA=;
        b=q/qgiyfrEHdFU6TeGd0d+esDu0V4IHfuBebB/dN6UmXgoNUHpwOvKBuvrAF1Bm1s5OUjlp
        EyogPYXQOvdheT2V079uiUZBNJNnL73SRGY+umBuy5vMnWnEPhqC5u+4IMM1tqdMAzMoUS
        sg0o5v+/uEcwrvtb0tzecD+40YV0mHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692383042;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SX+D2sM86o3QGpOyvkgvl+QwlBYRKQsPyzgbZzO4nyA=;
        b=YKUqdP3ZLE7Qh/O516Dsfs9/jy5m5Zx2mbBdxa48rO+L5tyVr+KSNcuqxNGifZn44HG6Jv
        5GhILpJ6bE5CvYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 988CE13441;
        Fri, 18 Aug 2023 18:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CB0NJEK332SqMAAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 18 Aug 2023 18:24:02 +0000
Date:   Fri, 18 Aug 2023 20:24:01 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Message-ID: <ZN-3Qfp3CyNiwJBK@suse.de>
References: <CGME20230809144403eucas1p1345aec6ec34440f1794594426e0402ab@eucas1p1.samsung.com>
 <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
 <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
 <ZN5n7GnlrTS6s5Yg@nvidia.com>
 <ZN-UpDFHab0vGuXp@suse.de>
 <ZN+XE7dk04f2C3D7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZN+XE7dk04f2C3D7@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 18, 2023 at 01:06:43PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 18, 2023 at 05:56:20PM +0200, Joerg Roedel wrote:
> > On Thu, Aug 17, 2023 at 03:33:16PM -0300, Jason Gunthorpe wrote:
> > > Bascially.. Yikes!
> > 
> > Hmm, that is a difficult situation. Even if the problem is a misuse of
> > the APIs we can not just blindly break other drivers by our core
> > changes.
> 
> They are not broken, they just throw a lockdep warning and keep going
> as before. This is what triggers:
> 
> static inline void device_lock_assert(struct device *dev)
> {
> 	lockdep_assert_held(&dev->mutex);
> }
> 
> So non-debug builds won't even see anything.

But this still means that a function is called without holding the
proper lock.

> Historically we've tolerated lockdep warnings as a way to motivate
> people who care to fix their stuff properly. eg the Intel VT-D had a
> lockdep warning at kernel boot for many releases before it was fixed.

There is a difference between knowingly introducing new lockdep warnings
into upstream and letting warnings discovered upstream rot for a while.

I can't send anything with known problems upstream.

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman

