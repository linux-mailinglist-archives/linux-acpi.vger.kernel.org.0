Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60194749052
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjGEVzJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjGEVzI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:55:08 -0400
Received: from mail.sitirkam.com (mail.aurorateknoglobal.com [103.126.10.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9451BC3
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:55:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.sitirkam.com (Postfix) with ESMTP id A3AB859E35DB;
        Thu,  6 Jul 2023 03:47:19 +0700 (WIB)
Received: from mail.sitirkam.com ([127.0.0.1])
        by localhost (mail.sitirkam.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XQO-Yrbd2LDj; Thu,  6 Jul 2023 03:47:18 +0700 (WIB)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.sitirkam.com (Postfix) with ESMTP id 266495AC61C3;
        Thu,  6 Jul 2023 03:47:09 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.sitirkam.com 266495AC61C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitirkam.com;
        s=B8AB377C-ED3B-11EA-8736-9248CAEF674E; t=1688590029;
        bh=o0S1lLmVeP1x1ARSYHBo01SF2R+WrUvfnSqBgm2xusw=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=lPCxdeDbgzr9Y3ofPIo5uSgsbU9jy7cYMgczJTPAaHCVtLjUXYMN+bz9180M3XcMM
         sb+USVW9J3ItB6NpRNIpTBoPPNRYXx/nUg+EUOpkocZpZvfeZKQiLeYiJ7/vYspTUT
         F4Uooba6RZZBiWSAQN7ftxxVjEcXPLar/FedFGvOwcNgdUMbr1b5WfoDOIcHfjoEBb
         tlY7U39KrpigZlRuik55b4+M2R+jJ9/WMmMpBhMoywDV6xeeHJraXf9XdT0qqHyITo
         XtJ/C1BAMsfx5VlEoo2bS5/vACG8Q9dCRzQLqE6bWJFvLbmAcrTROmXQfr1P07IQ+v
         9k3dMPVnRWrVA==
X-Virus-Scanned: amavisd-new at mail.sitirkam.com
Received: from mail.sitirkam.com ([127.0.0.1])
        by localhost (mail.sitirkam.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VM8CMrUL7pBq; Thu,  6 Jul 2023 03:47:08 +0700 (WIB)
Received: from [91.224.92.18] (unknown [91.224.92.18])
        by mail.sitirkam.com (Postfix) with ESMTPSA id 0D19259E2358;
        Thu,  6 Jul 2023 03:46:58 +0700 (WIB)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re
To:     Recipients <admin@sitirkam.com>
From:   "Scott Godfrey" <admin@sitirkam.com>
Date:   Wed, 05 Jul 2023 13:49:21 -0700
Reply-To: scottgodfrey858@gmail.com
Message-Id: <20230705204659.0D19259E2358@mail.sitirkam.com>
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: sitirkam.com]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9999]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9999]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [scottgodfrey858[at]gmail.com]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  1.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

YOUR EMAIL ACCOUNT WON A DONATION OF $3,500,000.00. CONTACT FOR MORE INFORM=
ATION ON HOW TO RECEIVE YOUR DONATION. CONGRATULATIONS TO YOU.
