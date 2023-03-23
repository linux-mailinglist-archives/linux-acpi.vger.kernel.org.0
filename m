Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2536C6E8C
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Mar 2023 18:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCWRUX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Mar 2023 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWRUX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Mar 2023 13:20:23 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5846726866
        for <linux-acpi@vger.kernel.org>; Thu, 23 Mar 2023 10:20:22 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4PjBtX5RF7z467s;
        Thu, 23 Mar 2023 13:20:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1679592021; bh=iIx7NcSq66PJ3KmXWTmH1eA6nDrxBVxiXpoKzbS8Fx0=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=BJa/36btjyCUjz9zZxH1/vj4A1ZplybWRm76YC8sQ2ciJ2S2kax6eDT4nWqdc6bP8
         5ActKHvnIkCvntIAx9aXBRRQeQ4wR0jWL93T89yGtb4jNi2gBtVsPRi5TOFpSyPaUw
         qFhFmnbQAbwZbdQ/dNOEM75xIqwoyeIeOu0kUje8=
X-Panix-Received: from 166.84.1.2
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Thu, 23 Mar 2023 13:20:20 -0400
Message-ID: <303883d55a6e3926918293878a173e50.squirrel@mail.panix.com>
In-Reply-To: <20230323131646.xp3m2qvb7wp2wsqb@pengutronix.de>
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
    <20230307093308.m5enhuegm3r4qwvo@pengutronix.de>
    <220898e2276e4cae2572eb8f006f3a7b.squirrel@mail.panix.com>
    <20230307161005.6m6fpi3oxa3jn2wg@pengutronix.de>
    <6d97df76de719871c90fb59726f2d6b0.squirrel@mail.panix.com>
    <47a90870-8a71-a28f-bd8a-032a69cda596@leemhuis.info>
    <20230323131646.xp3m2qvb7wp2wsqb@pengutronix.de>
Date:   Thu, 23 Mar 2023 13:20:20 -0400
Subject: Re: [Regression] acpi: laptop panics early in boot
From:   "Pierre Asselin" <pa@panix.com>
To:     =?iso-8859-1?Q?=22Uwe_Kleine-K=C3=B6nig=22?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "Pierre Asselin" <pa@panix.com>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> On Thu, Mar 23, 2023 at 01:31:37PM +0100, Linux regression tracking
> (Thorsten Leemhuis) wrote:
>
> [snip]
>
> I didn't create a proper patch because I thought someone might want to
> do a deeper dive and check the logging. If that doesn't happen, I can
> followup with a patch.
>

I will test any patch anyone cares to throw at me.
--PA

