Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CDA3FF3FB
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbhIBTRU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 15:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhIBTRP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Sep 2021 15:17:15 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5110AC061575
        for <linux-acpi@vger.kernel.org>; Thu,  2 Sep 2021 12:16:16 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id f15so5904446ybg.3
        for <linux-acpi@vger.kernel.org>; Thu, 02 Sep 2021 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=7cbYprtViCbGFSCYpKEkbMaY3bf1Nu/Wu2L8+nrDJDY=;
        b=Ei7kwHZ8uCeElPlQ0DB8YQo4G2+UKxudXQlhBuJ7Hz5WbD9lgedl9HENVMv2Lcdy/0
         TDr2/aysmrLEEMJNisbCYNlwnfgg9V2oUDqsOUiNaC0fy5/naBZRRTlZjljKrz1fi3vA
         wfBR/Ur9XF9U3b6XyvSDaDIym7iDolsTxpZ8UnuvPvnc1SPr6wFh9InkA1jLHkwdhdkp
         jJzT4r7LlVfmobVUyVOSqayx3vMrBaKq7W09mggdM+zQIwYeGp3Xhog5nTpnig0ky2DH
         4Q+z/qLkywHoleFldjcICJIv4242ka1jUwPY4TNpKApC4HfXz4J+3bF/yil/fKQ2wJpA
         Gg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=7cbYprtViCbGFSCYpKEkbMaY3bf1Nu/Wu2L8+nrDJDY=;
        b=HuLHHs7J4VMZde91zelOUNJR6tuWHJZr5Q/rMR01kCHVfes3l88pVO7huG5tpN36qv
         U35NfQ1q/06DnEGqM2DEV9hLHx9k+KQm4up9HG964Z50RW8zPq761EamgwJewO36mgdE
         Qpb9+F8OWFdHZ5ATTDdF8r/YdnMpa3djkh35jFu4SIcV+kR87+6LCLwVDTgRjne8yuMN
         Uq/9vICZhsltQlpeeGBiz2smhj88+RR9zAZuusm3WJiCk28FAVcaDPvdEoBWNmGmYrHw
         fE/t+L/ASy15uSNDKw8SytV+n1wHP50pnv6PsrezjiUrj8CwVL6ne5Ies2Xmmrm14Wer
         CR4A==
X-Gm-Message-State: AOAM531Xtpus2pmPs2cPQTCctNQehksgQEXHBWD7gkm2jkkZrCR0oYat
        qPjhfuRf23zX2HFcLv3fbfMV2hG/whBI0DgV1y8=
X-Google-Smtp-Source: ABdhPJwPI80WiASmx6/+XkIWGCSNV5/tyuNmabsQRAxITDspj29IkzN5SbtPgID1YLvOkn6oq89JPRZc0p7ACaEta5w=
X-Received: by 2002:a25:6d08:: with SMTP id i8mr6198659ybc.100.1630610175299;
 Thu, 02 Sep 2021 12:16:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:9716:0:0:0:0 with HTTP; Thu, 2 Sep 2021 12:16:14
 -0700 (PDT)
Reply-To: officebankdirectorwu@gmail.com
In-Reply-To: <CACOECawSMCrb-XbcQ5JQKF-1-2E7FJc7tjLYDYddbDC6fcaKgA@mail.gmail.com>
References: <CACOECaw+PAa_-xZz-xNzPNwHYnGAomZ+8_mq97t24CswRG_3hg@mail.gmail.com>
 <CACOECaygxwasn8fyni-mx=oWd3Uq6HONEZzExT63zYR01e8oUw@mail.gmail.com>
 <CACOECayzGzg5cLSMxe=LWP3-GOGRzxAxu6L8PBtjSGTzz3t+Bw@mail.gmail.com>
 <CACOECazbgDeqrUz2EXS8ZiHdxNN0uL7KvW+x+CQquyyP_LEQnw@mail.gmail.com>
 <CACOECaxORDf0W9MgdZiDsRTbY8BgfJK2OF+peeW_cUDtRmyeMA@mail.gmail.com> <CACOECawSMCrb-XbcQ5JQKF-1-2E7FJc7tjLYDYddbDC6fcaKgA@mail.gmail.com>
From:   "officebankdirectorwu@gmail.com" <bankdirector001@gmail.com>
Date:   Thu, 2 Sep 2021 19:16:14 +0000
Message-ID: <CACOECaz-JHBxDHxw4gnN_jRghN3dASzx1jLzXzFoWeEBir1VVQ@mail.gmail.com>
Subject: WU BANK DIRECTOR
To:     bankdirector001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

 Our office contact, 2554 Road Of Kpalime Face Pharmacy Bet, Lome, Gulf.

This is WU bank director bring notice for you that  International
monetary fund (IMF) who compensation you sum of $850,000.00 because
they found your email address in the list of scam victim . Do you
willing to get this fund or not?

We look forward to hear from you urgently.

Yours faithfully
Tony  Albert
BANK DIRECTOR
Whatsapp, +22870248258
