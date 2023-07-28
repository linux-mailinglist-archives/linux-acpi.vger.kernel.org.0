Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8599076641D
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jul 2023 08:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjG1GcP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jul 2023 02:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjG1GcO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jul 2023 02:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29FC2135
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2023 23:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4187361FE2
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jul 2023 06:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A350C433C8;
        Fri, 28 Jul 2023 06:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690525932;
        bh=XlJgPdB7Fra49fkaKOTlwTGOzVFQUq9qnjGcmKjDDtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUC2itpWcJl5TnE9sR/BkMdqDIvrZ1ybjS3UnhIw6zUGyP7CLHNNf3G27wQIsHd2e
         ItJ/HqyCYRNU/qsOJ8Kkk6l4IcMALtDyUW/Q++86+gbWdhmXaedkiG8hGKN5fW/bVc
         hiES124ygVY0sdN1SixB0UZuzCqWfU1j4zV3AXsNxtvHKUlZ7oTHgjz9pm5M/BEtLT
         sD5WLVtGGE3T7BLjbwk0jt2UukknCQQT25CWmCnl6A4BzC3IjqdVJO5cBfMFU1oeYx
         OpuC0AYrbB6EAoh5go2FMhPENFbY/Idp+oHbtw6wGa/vA+rlMRfcP4FLr6s2zSZUjj
         4+snmm+w+oxcg==
Date:   Fri, 28 Jul 2023 14:32:08 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     bleung@chromium.org, groeck@chromium.org, rafael@kernel.org,
        lenb@kernel.org, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org, guillaume.tucker@collabora.com,
        denys.f@collabora.com, ricardo.canuelo@collabora.com
Subject: Re: [PATCH] platform/chrome: chromeos_acpi: use official HID GOOG0016
Message-ID: <ZMNg6NYSgTf3mIRJ@google.com>
References: <20230728014256.3836298-1-tzungbi@kernel.org>
 <fb9876f1-e729-f2d3-75d8-55fdae24e3ee@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb9876f1-e729-f2d3-75d8-55fdae24e3ee@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 28, 2023 at 10:59:22AM +0500, Muhammad Usama Anjum wrote:
> On 7/28/23 6:42 AM, Tzung-Bi Shih wrote:
> > Use official HID GOOG0016 for ChromeOS ACPI (see [1]).
> > 
> > [1]: https://crrev.com/c/2266713
> > 
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> > AFAIK, there has no ChromeOS devices using the driver yet.  Instead, they
> > still stick to some downstream implementation.  IOW, I guess we are safe
> > to just replace the PNP ID.
> GOOG0016 got introduced in newer firmware. Older firmware will still have
> only GGL0001 id. Lets keep both IDs otherwise the updated driver will not
> work on older chromebooks. This can be easily achieved by keeping both IDs
> in chromeos_device_ids.

Thanks for the review.  I overlooked the case.  Will fix it in next version.

So if I'm looking for the path, whether it bases on "GOOG0016" or "GGL0001",
it actually depends on what firmware the system has?
