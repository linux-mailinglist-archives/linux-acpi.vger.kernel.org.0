Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D39E557D1B
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jun 2022 15:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiFWNeE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Jun 2022 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiFWNd7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2022 09:33:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C615E2657A
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jun 2022 06:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3710B61DAF
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jun 2022 13:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B3BC3411B;
        Thu, 23 Jun 2022 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655991237;
        bh=zFaT66Zn1kjbviwOX5/wuUv0LG+iK70L9huwKUeDc4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjg0iIxR/3aadqr3z+D6BJl6XHzt9dzxMYtxvLwTGQMEKpd82Mdxz1vciVGWOk0Tb
         p/dwNMlISL3AhUBy1sDP66jy+afZy1SYr0v6RaHLP1iRsmexlOl4+Wj9TMW089mosp
         yhhvfYs9LDcYs8NHjvOZZl5CRtNpP4AdZgA66sZI=
Date:   Thu, 23 Jun 2022 15:33:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
Subject: Re: "Revert "ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag"" is causing regressions
Message-ID: <YrRrwqc69MgpA9kl@kroah.com>
References: <6d7e3740-6107-dab6-64de-b4a978ae329d@redhat.com>
 <eabb9172-3227-3c12-5553-3de202a2f63a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eabb9172-3227-3c12-5553-3de202a2f63a@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 23, 2022 at 07:24:34AM -0500, Mario Limonciello wrote:
> On 6/23/22 05:06, Hans de Goede wrote:
> > Hi Rafael, Mario,
> > 
> > Commit 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the
> > _OSC regardless of the query flag"") is causing the issues fixed
> > by the reverted commit to show up again, see:
> > 
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D213023&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cf3e0e967549b44bfc78e08da550012c9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915756056744972%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Y0NhQJHeimPYw675CW2hxF9BHc102X8Kl9iQRC5tmyk%3D&amp;reserved=0
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1963717&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cf3e0e967549b44bfc78e08da550012c9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915756056744972%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Y02ntSQcVqhiqbVGsxys0BSeiv7BmxIRZIoxzdMHxKI%3D&amp;reserved=0
> > 
> > both of which have comments from the reporters that
> > the error message is back again; and presumably also
> > that /sys/devices/system/cpu/cpu0/acpi_cppc is missing
> > again.
> > 
> > Can you please take a look and see if we can come up with
> > something which fixes both the re-surfaced issue, as well
> > as the issue which the revert tries to address ?
> > 
> 
> 
> Is it possible that c42fa24b44751c62c86e98430ef915c0609a2ab8 didn't backport
> to the stable trees it popped back up again?
> 

It is only in 5.18, no stable releases that I can see.
