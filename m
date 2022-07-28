Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A645840FF
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jul 2022 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiG1OXX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jul 2022 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiG1OXW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jul 2022 10:23:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D385C344
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2022 07:23:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e132so1665994pgc.5
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2022 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kCSqCOP5NnmgqzMKAvoC+xj8lkHVueu0SPSEqGKA1Ew=;
        b=jhshiq4+diWhUqdzg9crL6G9IpwmGj43lEs/91L9dXdyaKWdEMBsPr0oKa2zj/yZcX
         iNpnJmsC4CFarsZZqhDYhgvwgqoSwHqOMIapEr8FAEVwB4MIroytm9DT1412B7YEKzW2
         DDlrnl8sU+EWXtb92eopinKDYTPFHAMWzEi1lzQw3/XkLuF5aRlyuq46zI8cO05jKGpc
         YCBlhvdStHcvOkBm4GUOQPMOZqWtoRnloTTDGdv3qVEUo8Cl+WkcbDEvPjbjLJLKnRb5
         AxfhmWXB409FwbNsfMNENl8Z+sYMClpVh2HDe/m8al8JjMCOZ6JUXTDvHhdv7gpd16XD
         o5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=kCSqCOP5NnmgqzMKAvoC+xj8lkHVueu0SPSEqGKA1Ew=;
        b=WWelrrDzXjM3lOlQ9DAdfjw5m+PJ59gS9MJVlOs/6JAsInHhczlEloUX8FMxw2mEmO
         ziqjLdKZBHoiCNXz/oSMiDnhfhrDbehbgNfm2GrHD//5ZiCV63YBNUBIaLKFKQiGeVOf
         jcy0tUvfqgixYicnaN81wa6niNNtFwOqke52JrFtbxLkCG1t78NeXygBISXtDOrnraAM
         GL+V8P7fKzeujLfDtrQb5V3rDkSRRlgHjed0hGvM+1ZWqz3xchRRQEmlyw4Pb7ZL3VfR
         BuKCKOgg/e/BszZr3rDG0yblcwLVkJaUPeghcWUpXZKios1NCI7jeoo+uu9Lb6ltltvM
         IN3A==
X-Gm-Message-State: AJIora/KxpDzOtVRXnksqkvLccslX+eJAfMxErAP3A9R0SZ1D2kdEz95
        wkWaIXsh/wI1eBmrSNLF3UyZWUdcv4xMYGOSnBU=
X-Google-Smtp-Source: AGRyM1uusxWGi9yoSyo3nmXVxdPfzcm6B6Pxp2Yuj+z2RHPKUecQmi7GmH0oWbGNugjJzrMpfN7S+SDdCwJi6MGFSFM=
X-Received: by 2002:a05:6a00:27a4:b0:52a:e490:3f8d with SMTP id
 bd36-20020a056a0027a400b0052ae4903f8dmr27174000pfb.45.1659018201609; Thu, 28
 Jul 2022 07:23:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:678e:0:0:0:0 with HTTP; Thu, 28 Jul 2022 07:23:21
 -0700 (PDT)
Reply-To: lisarobinsongift02@gmail.com
From:   Lisa Robinson <benjaminkitavi49@gmail.com>
Date:   Thu, 28 Jul 2022 17:23:21 +0300
Message-ID: <CAEwLOJVmkUTptDt_a4QchXapWb+LLjtoyv5NbtqQm-UdGCRagA@mail.gmail.com>
Subject: Donation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7791]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [benjaminkitavi49[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lisarobinsongift02[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [benjaminkitavi49[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--=20
You were chosen by God to receive my Grant Donation of 1.200.000,00 =E2=82=
=AC
Please contact: Mrs Lisa Robinson via email:
lisarobinsongift02@gmail.com
Surname:
Country:
WhatsApp phone number:
