Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA34267B77
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Sep 2020 18:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgILQwt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Sep 2020 12:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgILQwn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Sep 2020 12:52:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CB8C061757
        for <linux-acpi@vger.kernel.org>; Sat, 12 Sep 2020 09:52:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z19so9389678pfn.8
        for <linux-acpi@vger.kernel.org>; Sat, 12 Sep 2020 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:date:from:to:reply-to:content-transfer-encoding
         :subject:message-id;
        bh=z9cbGQzvCZGdv2stQ4JjJcY1G86CqEMBICg5YK+66dU=;
        b=tq5TVoZlBhOE5vi8NspSGpvioI3vzDz9TCD2cuc8Ti0aKFjL1ZMeOR9vcT6b/9bSiy
         eBE1jiCD84vJzAQ9FfKO9Ek1LpWjiDucR2E4MexVmmu23QZ+QzckuEOOEXLUeZOl46x7
         Mq7riVRNv8ld/XHgHFiMjGZeOGROvsUvq36chTEyRnQuWjat8l05XfUMbVQa4lNrsW4e
         mi48bWafyN+zwJfvMNraEiJVzFeiJRsnAgpD/vb7S9KG8MmzqeHJc1y3qyT3aHQOXbDD
         f5wYeF0GQVYygjsYvPo/lniZW3YREZD2fijuXPFzkDxV6rqifqJqVFb7/S34/BW2XUAW
         4t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:from:to:reply-to
         :content-transfer-encoding:subject:message-id;
        bh=z9cbGQzvCZGdv2stQ4JjJcY1G86CqEMBICg5YK+66dU=;
        b=gaLIOyIaM2oDDTVQEz7aijunDurUqeHxB2ZACcMlnijuwne6mjTtYZs8Nv3LgmoRSh
         5kyH0TMaL23HBPD4QBYv+10PJ99iYMueT4U6Rusu+SOJCHEDeGw2ArQ4nevyAyqjqh4Q
         +Jm9o2gLW9PGW6CXYr/uEv37kk7eao+galKs4Qr9SW6Q0QzRVb/KYmWynYeeMAUpiMaQ
         7EipO+bkRW609CxfYnBEXEd/Am9Beuh3Q155pQuL/IWXn2wMKE4SvqgG4/DN+SznvsSw
         yPgZf23s11pitItv4ouk0YDLumZZprruqQ/w7YPBCjvywXSm/PtL9m0Z5rLfQZrOP1Tn
         KMBA==
X-Gm-Message-State: AOAM530Cchus2f1GUNehCjo0heO/munEOzInIJ/xjNClHMCNUThdUhdb
        B9Bvx1WaDc6TuivJjd56b9wIUBSXfLw=
X-Google-Smtp-Source: ABdhPJzCl75Xnk55PMkvaVrSSXZcpPaRmu2TLGPv11hlnXXmV76Y643egFZu5RDoThnhO/Rg1ROuGQ==
X-Received: by 2002:a62:ce4b:0:b029:13e:d13d:a100 with SMTP id y72-20020a62ce4b0000b029013ed13da100mr6528871pfg.28.1599929561124;
        Sat, 12 Sep 2020 09:52:41 -0700 (PDT)
Received: from WIN-25FFVSIPLS1 (149-255-36-142.static.hvvc.us. [149.255.36.142])
        by smtp.gmail.com with ESMTPSA id c1sm5580058pfi.136.2020.09.12.09.52.40
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2020 09:52:40 -0700 (PDT)
MIME-Version: 1.0
Date:   Sat, 12 Sep 2020 09:52:28 -0700
X-Priority: 3 (Normal)
From:   sharigray1984@gmail.com
To:     linux-acpi@vger.kernel.org
Reply-To: sharigray1984@gmail.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Subject: hey
Message-ID: <94A8A370C206885311DD1D0D29C64A86C05F2246@WIN-25FFVSIPLS1>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Facebook sweepstake lottery notification, Click on this link to claim yo=
ur winning payment https://zfrmz.com/Ps5t04H6zwHXI1u9RV8F
