Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4879D7655BF
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jul 2023 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjG0OR5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jul 2023 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjG0OR4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jul 2023 10:17:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787639C;
        Thu, 27 Jul 2023 07:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1648F61E95;
        Thu, 27 Jul 2023 14:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15E5C433C7;
        Thu, 27 Jul 2023 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690467474;
        bh=E+cYYrtIJnle5ULk7Wl/qyr+CneU+qpZ7F6LQsocHM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqPkFSlWsEEgJ4/gLsVLDeRChjjfKC/1kZywIN70/kt49dTtDJBTh9F3N00ClTzSc
         lML93UcOBTOxSqh0uUHkDdehj0lgfOsMmakZIWde4HEByMdUBswt76Eimoil+X2Fw3
         cx0Wb0BRC4GmgXP9P9tsMWh31sLMpdB55NsOuOEA5uk0/KObgWyCP5yx+UAzCUjf9T
         ltJGjtb+wfYGiDOqFOsvyGOTQ1+gH6j3y3fDx3KoegrOCpZqC83fGbRpGJ5eqAGBW6
         eBqiIEFoXj/R2MK1awjKcuOkuHXvs5ttR3cURkNU/XonwdTZQanuwPPF/DZcFYGvPU
         RnPhzitvzHn/Q==
Date:   Thu, 27 Jul 2023 16:17:49 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, will@kernel.org
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
Message-ID: <ZMJ8jeLs69env0pL@lpieralisi>
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <ZMJzj2oe0B2Qp8vp@lpieralisi>
 <ZMJ4JnlVlqkO3E0P@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMJ4JnlVlqkO3E0P@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 27, 2023 at 02:59:02PM +0100, Catalin Marinas wrote:
> On Thu, Jul 27, 2023 at 03:39:27PM +0200, Lorenzo Pieralisi wrote:
> > On Mon, Jul 17, 2023 at 07:33:45PM +0800, Guanghui Feng wrote:
> > > According to the ARM IORT specifications DEN 0049 issue E,
> > > the "Number of IDs" field in the ID mapping format reports
> > > the number of IDs in the mapping range minus one.
> > > 
> > > In iort_node_get_rmr_info(), we erroneously skip ID mappings
> > > whose "Number of IDs" equal to 0, resulting in valid mapping
> > > nodes with a single ID to map being skipped, which is wrong.
> > > 
> > > Fix iort_node_get_rmr_info() by removing the bogus id_count
> > > check.
> > > 
> > > Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")
> > > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > > ---
> > >  drivers/acpi/arm64/iort.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > 
> > Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > 
> > Catalin/Will,
> > 
> > can you pick this up please ?
> 
> Would you like it merged in 6.5 or 6.6 is fine?

It is definitely a fix - I don't think that's super urgent
though, bug has been there since v6.0 so the fix can probably
wait to trickle back from v6.6.

Thanks,
Lorenzo

> Thanks.
> 
> -- 
> Catalin
