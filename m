Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6C5764251
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jul 2023 00:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGZW7N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jul 2023 18:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGZW7M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2023 18:59:12 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 15:59:11 PDT
Received: from abi149hd125.arn1.oracleemaildelivery.com (abi149hd125.arn1.oracleemaildelivery.com [129.149.84.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83C42720
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jul 2023 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=P5XOpKDXF2I6R3nLKrm49oZh2FlsW7OS7CKRX6CPNiQ=;
 b=moHN+0yB5775OaTCkulEdw/A3GeYahNG1NiLULevqihOeasZ+stZJh3Hf41RcNGWRQyY8ywfk8Hi
   YvNLXf+XTPLEbrtn70UZphcmvq07+nG/7UzWbPHyk87N/Z4HPVJDHJrJRIlC3SA/wTRuLz8bo4T9
   tGKBR2nI2yQ467s+B9GvXQP9B2qe9STSIrke07PnZxjyy7nOU76C4SKjwpRTGS+p1RlpDGl8lRdk
   DDZzib4PDJluL/W48vOYez1cm2vUvjNUMpnjOBoB8uhe2gAQJcN6mdLU7CzNE0yNjzcDb4uYUPYX
   pfT5iVVi5p4o8KJHEnjh6G95j2VUgZ56hbQZXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=P5XOpKDXF2I6R3nLKrm49oZh2FlsW7OS7CKRX6CPNiQ=;
 b=XfYf2OgHATJ5LFxRpvQhyMP7wWriesITIvVNzqmqP8EF8muwEpA0sV6lI6a1RUYmlmyHWlrDerED
   vlhwBcq5yXvFuzWeLUdH/KDCrn3qe7f4MKQVKZgmyrV9tVgPRkeHUzZx13ty9pnwRPq/8snig6kV
   vPTXDace4Wf17+0RCmAD1MY+lp9LyO8zm4eXtHswyR3kiyIv0kbPNPrPG8wBLhuPACHowmAF1/NK
   43a/CgmVP/q3mwOdDKov8iF1PteHllX1UTCVCZizWNEasibweohDCLuB5T0yRAmimzwDluz3rmEF
   JDQec5kS9DC9e6LKddPa8pOU/xew7SFne2PX0Q==
Received: by omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RYF00GIKEA606A0@omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-acpi@vger.kernel.org; Wed, 26 Jul 2023 22:54:06 +0000 (GMT)
Message-id: <596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se>
Date:   Thu, 27 Jul 2023 00:54:03 +0200
MIME-version: 1.0
From:   August Wikerfors <git@augustwikerfors.se>
Subject: [REGRESSION] IRQ override revert breaks keyboard on Lenovo Yoga 7
 14ARB7
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Content-language: en-US
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAGnM6W8OrXL2D+FP6EMe5jLrw6d5HFTLzCAq4llZKfL8+RGXIV+2M5ejmHh35jV
 XcXIenFX1c2j/twuJhfQogW02hiG3OymSz/knlnthmeGSaFiwvwd2rz4aF8ZWp9z
 uPWa15a6/qkzpq0ZLtDcfKWyewqvKWBN1oLeVSE6mELjDHpwYMPT255ls1yvCSqA
 U7xgPNQPxO9xfWwdfogI/QCqiJhTKv4N51g1LplUPLPVhpKsuDtdtwnzOY8TYgvl
 zR1VhMP0vQ8C1QIP6WkbjhbPHWebduZS5xr+Z6zSxy4lEpUarF05A3bTScJ12A27
 /k8cQaaH/CY0CwX/BFJEUj+tjT8O8mA9aE8TELfBfaDmcNQHuNCmSdknfopiWidf
 CziRSad/9ytncOOwpL9+KEYoyWKtMhX8CtX/7qiDNwvzJScqox8kPVsCvS89w/iR uuHKWps=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Since v6.5-rc1 the keyboard on this laptop no longer works. This problem
also existed before v6.0-rc1 commit 9946e39fe8d0 ("ACPI: resource: skip
IRQ override on AMD Zen platforms"), so I suspected the cause to be
a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
which reverted that commit. Reverting a9c4a912b7dc confirmed this theory.

#regzbot introduced: a9c4a912b7dc

My specs are:
Laptop model: Lenovo Yoga 7 14ARB7
BIOS: K5CN40WWT66 (latest beta from [1])
CPU: AMD Ryzen 5 6600U
Kernel config: [2]
Distribution: Arch Linux

The issue has been confirmed by at least one other user with this
laptop: [3]

[1] https://forums.lenovo.com/t5/Lenovo-Yoga-Series-Laptops/Yoga-7-14ARB7-keyboard-lag-when-on-certain-websites-or-when-Vantage-is-opened/m-p/5174991?page=28#5974742
[2] https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/d4a56a1e994201b6c607199922aa22e4337b56c9/config
[3] https://github.com/tomsom/yoga-linux/issues/47

Regards,
August Wikerfors
