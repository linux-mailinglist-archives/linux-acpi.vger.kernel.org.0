Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE6A66BC36
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jan 2023 11:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjAPKxQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Jan 2023 05:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjAPKxI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jan 2023 05:53:08 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA241A4B4
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jan 2023 02:53:03 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id y18so26020551ljk.11
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jan 2023 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAGV2Q8tueB9u6nAu32uT5tMQP/9mkBrRApmZJ0yLwI=;
        b=gbTjzzezFxCudxRkavYhx4+oCu91FQryEFwMS7mr+EElmC0AigBmPZ0qN3lJ1cGiQk
         KF4bbGVRbL+Fr0zWMEeD5pS5OV/T9GNoRWce4vRHGopiRlECTB18AIKRJVDZHmBYnDJJ
         vwLE0tFJcV0iJo1KzSc77Z9tkFiAhN7hkxLWfPaPJuJ5XDGGCaOAwClUVfCWKy6WGsNG
         qvbHv/5OYth6jdRcVOudoBcGrcSjE/xKf77t4IcJrsfsUngZ836m8KtY2EuA/tU4epa/
         mNwDd9yg1E67HhoqjRcZ1GfDvE4W4i+Zgud64zOqPQrI+QV5h9eytEDjN9ix7GimPX1m
         WUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAGV2Q8tueB9u6nAu32uT5tMQP/9mkBrRApmZJ0yLwI=;
        b=rs9ays2dzsMBD7fzfjtOXbG6yfO6QbCNScG4lVum8siLd9QpmoaFjUUBaVUMdWgPPS
         59umWWeFAL3KYW75Ao1k+Km9gR5oQk2aJ9l89DP63NTexUHa24QnZSYpusr4nKlIi59Z
         xiEobRMhdyLiMhC1BJwDGL88zkxAHXo06IiAGb7tkevPRzDGbHCZfIwW7GEYq7Cg1WEu
         zAd7dG07SoPkwnvOh64IQQBSzqAYE87vtFXyebeQIU6gULe9vs9KGgTlJnTHjKOsSWzQ
         wZy43s25V6Eyt7OFcOtSlCiJP7f4TEgUrvcaAJxaxIHwTsjg3wyYrwnvHQ87hpLba6eQ
         tT/w==
X-Gm-Message-State: AFqh2kqsInQljFWWODzG8stq7bvLwS348DHirgXUdVmwqMj/C08eCL3m
        DxNFzMgbIxan86IUMCmMR5iTfiT8fBb8Vz20b00=
X-Google-Smtp-Source: AMrXdXsdacTY9BAdcFSik3lAol7yxOCGhKVNkOlmAmkRR2X64NxPTr4y2hXZYv/OIkvW0TBjTnVvembQEu77N0Tm3+o=
X-Received: by 2002:a05:651c:201c:b0:28b:6ec2:b1a0 with SMTP id
 s28-20020a05651c201c00b0028b6ec2b1a0mr325041ljo.146.1673866382057; Mon, 16
 Jan 2023 02:53:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:430f:b0:21a:12f2:77aa with HTTP; Mon, 16 Jan 2023
 02:53:01 -0800 (PST)
Reply-To: felixdouglas212@gmail.com
From:   Douglas Felix <df3038829@gmail.com>
Date:   Mon, 16 Jan 2023 10:53:01 +0000
Message-ID: <CAKKKU=QEHLmSecthtNdSmATZ3KH1ceHn2L9PeQ9Amk3a4ZYQPw@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to replied.
Kindly reply for further explanations.

Respectfully yours,
Barrister. Douglas Felix.
