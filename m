Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9BD5A53F4
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Aug 2022 20:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiH2Sa0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Aug 2022 14:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2SaZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2022 14:30:25 -0400
Received: from vorpal.se (vorpal.se [IPv6:2a01:7e00::f03c:91ff:fe73:398e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58853ED41
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 11:30:23 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 7F8FD140DD;
        Mon, 29 Aug 2022 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1661797821; bh=x3Jh97OALatCqdKI2nbZuuAfWBDs2g59b5Rhya0Y91Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WiDuIBk2MVAuJWRLBXbPPH8VMEI4PkuGe6YCQMlQC+fZSs/m6wHUc2Y8gq93xsymX
         m1mTLZpZjlFvbRekb4iBI8LR12jcgHZFFaPSgVG6FUQktWb66jFtrb7r8J7vJqYO/a
         j2A+9ii38qtjF5VIoT6VhX7lAljNBagWAJIc/wI+a98L1zd0DXxg7NJoat0IgrfGYD
         eBmTXnBNRdTXO06re9bWzWyXnwXRUDYfFoTmzrjkDF0/3wTYTqOOZ+POfiLur9KUZm
         NUS6Bu5XmAtNTW+F0h8zbUzamDg66MzrXcMgL9F8bPghCusv1l/+TLOp1w/pqNwCxK
         M3SCDwG9it1pw==
Message-ID: <ef3046e5-f402-3d33-8d94-4d9f87ceadd5@vorpal.se>
Date:   Mon, 29 Aug 2022 20:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] ACPI: video: Add Toshiba Satellite/Portege Z830 quirk
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220824184950.631520-1-lkml@vorpal.se>
 <20220824184950.631520-2-lkml@vorpal.se>
 <d097b844-8fe4-3469-2137-9e8407348175@redhat.com>
 <3863cad2-1910-b377-011b-4970eeb68e13@vorpal.se>
 <91260f39-27d9-222b-53e7-41ab4bb412a3@redhat.com>
 <9640be14-b478-5887-9057-de2796eccd6b@redhat.com>
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <9640be14-b478-5887-9057-de2796eccd6b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2022-08-29 16:12, Hans de Goede wrote:
> Hi,
> 

<snip>

> 
> Arvid, here is a git branch with my backlight-refactor for you
> to test:
> 
> https://github.com/jwrdegoede/linux-sunxi/commits/backlight-refactor-for-arvid
> 
> If you can give this a test spin (without any special kernel
> commandline options) then that would be great.

I'll set up a PKGBUILD and get this built (I'm building on other computers).
It may take a couple of days before I get around to that however. I hope
this is okay with you.

<snip>

> Regards,
> 
> Hans
> 

Best regards,
Arvid Norlander
