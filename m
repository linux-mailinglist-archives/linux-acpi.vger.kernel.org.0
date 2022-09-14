Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CF25B8A61
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Sep 2022 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiINOYW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Sep 2022 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiINOXm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2022 10:23:42 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8604F1B9
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 07:23:41 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso10430505otb.6
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2022 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=T/W399ugEDVZD4m/kuU/Ot70q1nwjtLdgh28FGL9vuI=;
        b=aTeT17jIkygmWeAvV0hUJ9RK0Y7BOMxPPRvu2Zb+Wj3oDMBARAGTLh+QpXOerih+At
         fFF66M3tONgatwL27Hy8mmC9FRh8f6XbDC3g3p9mOthMy78QpROEBT1VKKJdwtAthpLH
         NkFU/vOxzZRgT6eNUzqXmiknkEuJ1cjpD/Nlf/Tz3yZLaFk0Fr9GDUSp6icnSOkTWJN6
         kamFu2QL2fGNiI2NP5q6zkySnGeWP9ICXfINfr4f8bYxrnCN1i5OL0Co5W0apoPY2pmN
         VdrvVvm1lpfUE7u/1TY5M0fnPbTIfqJXGt/rBAQIotyNhzbigzSXN/hmgqP9tRqN4Wsn
         zqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=T/W399ugEDVZD4m/kuU/Ot70q1nwjtLdgh28FGL9vuI=;
        b=0rhBlRsJDQXSUbtvsoSW31gxZa6879iwAnwqo10eT1fX4XT+UH11CEaL2MTq6g2Aen
         LVFa/YZG23+j+E6h7I8Ye0q3OzOwBd1WmD2pl//rOlfgfMUhXADQMbY+9uZAbRRcOAKl
         G13tNnMBRK5ip+DARLbqheo56eNA81CjVpyW5bM++aIovKw9OsZX2peemHJmd4iXvrXw
         1/gAcH08I6DGy4cN9tcdiF9IVgDX4NGoGXd6/hYCIwUSogrbVcegR2fvMt4nirdWv17i
         mb1No1RRMXjJfsNjTbI+P+/FnCi7QXm0YYFlZ/0kPMJyulIbFCl0D531ovDqcljDDrAR
         eYbw==
X-Gm-Message-State: ACgBeo2g+mCwUGzOyqjuP/amh3t3Hdb9l8a4FWQx606wZVAtra9WdlQO
        A3SSPXl7vnIfZRjwvc582EIghqzD/UscravC3cQ=
X-Google-Smtp-Source: AA6agR6MreNcoc3OLEybXhazHAES5NYSAM694cN2xPX/OJfm2aEw8A8dU7h0U4l4qRwVi4gT5ur/LmNluSqCMtOpbwA=
X-Received: by 2002:a05:6830:111a:b0:655:bcad:f65d with SMTP id
 w26-20020a056830111a00b00655bcadf65dmr8920425otq.133.1663165420829; Wed, 14
 Sep 2022 07:23:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:168b:0:0:0:0 with HTTP; Wed, 14 Sep 2022 07:23:40
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <tchasrazak7@gmail.com>
Date:   Wed, 14 Sep 2022 14:23:40 +0000
Message-ID: <CALHSC9K-18V5-KdHQGw_JSdwp+mvUjcLOPYmZ7mVTa_zqV1tUw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:332 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4977]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tchasrazak7[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tchasrazak7[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylam28[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

-- 
Hi,
Did get my previous letter? Write me back
