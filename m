Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB1F6AE26B
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Mar 2023 15:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCGOaZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Mar 2023 09:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCGO3s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 09:29:48 -0500
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B018C59B
        for <linux-acpi@vger.kernel.org>; Tue,  7 Mar 2023 06:25:10 -0800 (PST)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4PWHln2L79z3lMq;
        Tue,  7 Mar 2023 09:25:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1678199109; bh=iKqTJyMs5p6z903qrfFiEeNAVFvQQXAKyI9pBRJ4e6s=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=JxbBMj699F6EU7HWKALZnxSV7OJjEWB+o+/YIgKIV2aJOysy1XhcUMwxKWbTvwuHH
         6HUX8st8idLfbejXC+dF3zmNuxVwY9oJo8icEeBugAkKA3I2+yiO/aLgdTbGFEf7gH
         F/KBC3GGnxhiQB47OGLEH/R1X35KgCbchRpGTg7w=
X-Panix-Received: from 166.84.1.3
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Tue, 7 Mar 2023 09:25:09 -0500
Message-ID: <220898e2276e4cae2572eb8f006f3a7b.squirrel@mail.panix.com>
In-Reply-To: <20230307093308.m5enhuegm3r4qwvo@pengutronix.de>
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
    <20230307093308.m5enhuegm3r4qwvo@pengutronix.de>
Date:   Tue, 7 Mar 2023 09:25:09 -0500
Subject: Re: [Regression] acpi: laptop panics early in boot
From:   "Pierre Asselin" <pa@panix.com>
To:     "Uwe Kleine-Koenig" <u.kleine-koenig@pengutronix.de>
Cc:     "Pierre Asselin" <pa@panix.com>, linux-acpi@vger.kernel.org,
        regressions@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


5.19: good.
5.19+Uwe's patch: bad.

Slightly different traceback,
https://www.panix.com/~pa/linux-6.1.12-crash/boot-failure-5.19-patched.jpg


