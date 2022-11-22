Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DBB633290
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Nov 2022 03:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiKVCDY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Nov 2022 21:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiKVCDX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Nov 2022 21:03:23 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F9BD5A1B;
        Mon, 21 Nov 2022 18:03:21 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id c15so15729405ybf.1;
        Mon, 21 Nov 2022 18:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7SqnKaq0wZ3Ypodl8lAIUkjWtitllK4iWiIBbtfpnfo=;
        b=LuVIOMqsxbtMVbNf3lGAlfSqJQ34cyPGQ4pjS6OqD2ZS3XQZJ2tI3qt30Fy/q4Vfkm
         rK3My5ypSCa4rElTrLahu7VDIaPpKea4R72N2qlAtAnYLfYeGgbGaV/hLZMECT7fx5F7
         3yv8O/W6B14Xs1W7oeZvrrCdwJR1fnA2XA3S7ld5DI5uWqRY+H4wL1h+/7lNxuWNYpJq
         wBZVdmzl5x89+wrfoijH9T03Fh+Ua3T1znNfiHsv2nk6EDg+rkeoeuYFtSEaZ0H8kaWX
         4mg/QHEnqWV2xVYgFuFUjSGHL1T4qtWWwkX9J1IZEIsPpd2613Y0n20DlFBqk8aqQNzA
         tY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7SqnKaq0wZ3Ypodl8lAIUkjWtitllK4iWiIBbtfpnfo=;
        b=2Cgd8+OJzneaPtXJobjOl0uL49kgcUUsX/LkZqCrzgWk/fTQ457LPOjYNw6H2kN/AQ
         s3r9OWISB6KXxgIqNny9QK5NOwqDkDW6cDeAGkIdoHoLyg5FHoxovMtwFBR51BTkwAmL
         nUuXR0qfrLjrEqCvQ2nzmdW+DkE3sqRHFPcBEGyD3NnT16DY00eIAUGD8cPb5r4IVRq5
         +OadimAEEzQ4eeOilFY5fu4xTuEndtE/8KSrpl9mmvq317/lgLDdlcs4O0kcEG8ayKkt
         IVUwhblzPJdw2YmLxB7zgDGiM8Pr+UWCCt1WWmvBachMpph7v8PY0kQAFUetvBMHVxzq
         vouQ==
X-Gm-Message-State: ANoB5pntDYWvGR6pvUerTOGTsTamRkTvr4KN4DVOB3aWUDTgg+hJYHIl
        MvfYU0ghRwpIIJKlOqnyVgMHj3wGONRfSUy2lwH1zxmdhsbaPQ==
X-Google-Smtp-Source: AA0mqf5VA1v1zygNZuk9xikfSkGo2oIHhPDVRQkvlSxZecMjMsPtsUwgS39mVMfV2OwiQpBwUrQBENPHnaEEHZm6FWo=
X-Received: by 2002:a25:f30c:0:b0:6dd:7395:72bc with SMTP id
 c12-20020a25f30c000000b006dd739572bcmr1611042ybs.533.1669082600726; Mon, 21
 Nov 2022 18:03:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:9f88:0:0:0:0:0 with HTTP; Mon, 21 Nov 2022 18:03:20
 -0800 (PST)
From:   Felipe Bedetti <felipebedetticosta@gmail.com>
Date:   Mon, 21 Nov 2022 23:03:20 -0300
Message-ID: <CAFO8usyvQSAKfXR0EWDaPpHK+Y22XREd2v3-wz7iNtcT_sccBg@mail.gmail.com>
Subject: Re:Norah Colly
To:     linux acpi <linux-acpi@vger.kernel.org>,
        linux afs <linux-afs@lists.infradead.org>,
        linux aio <linux-aio@kvack.org>,
        linux alpha <linux-alpha@vger.kernel.org>,
        linux altix <linux-altix@sgi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,BODY_SINGLE_URI,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,TVD_SPACE_RATIO,T_PDS_SHORTFWD_URISHRT_FP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.5 SUSPICIOUS_RECIPS Similar addresses in recipient list
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [felipebedetticosta[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 TVD_SPACE_RATIO No description available.
        *  0.0 T_PDS_SHORTFWD_URISHRT_FP Apparently a short fwd/re with URI
        *      shortener
        *  1.6 SHORT_SHORTNER Short body with little more than a link to a
        *      shortener
        *  0.7 BODY_SINGLE_URI Message body is only a URI
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

https://bit.ly/3Xm3FtK
