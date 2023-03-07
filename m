Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C056ADBAF
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Mar 2023 11:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCGKVs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Mar 2023 05:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCGKVs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 05:21:48 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168F411673
        for <linux-acpi@vger.kernel.org>; Tue,  7 Mar 2023 02:21:46 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id bd34so7690413pfb.3
        for <linux-acpi@vger.kernel.org>; Tue, 07 Mar 2023 02:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678184505;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x50Qlw1MrbKfPc5Y3tqZO5+1c26Aew+5oqPX3JirLAY=;
        b=TE6E5VUw5HBCWcNlpvAPy28hQkL2NkgpzMKvh0VeYw15g57cfFt9feuOD/Ssme4V3o
         Z2nZ6xaG8XjcLVxK5IF8bLf5frNjEr1sgBGVgBZAFwOsbEzcWPBN3dbeyLWTKd9lCgOV
         ENj2MxgbHzr6pP9V0F7HTP2WObRDe1mEySmG+95zdrEmHC2YNnUPza5rOQftQwe5GtyW
         m95QK2UKZIe4B/N+/kV8XAPuqCucM2a37JwY/ZdSx7Em9eAXBdznSq0ro6u0iePZHiIw
         rCZ8uFOOvhfTYdY12jO2qv7m6PHMiFz6Ow8bpakNu5u5W6WlLiHLjH1BCv8yhoRqh2jA
         knuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184505;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x50Qlw1MrbKfPc5Y3tqZO5+1c26Aew+5oqPX3JirLAY=;
        b=cqAalqFdx3xiBd/ntALLTQgHfsaTdAaKHYr23TTiqbOHmqTVHQ7LztexMNL8en8rOa
         CXQUE14hQxwo3gnv3J9969hrYG4hS8EA+9iBd/iWVjo1BbDm4uVbNgYAwEgo5RC/Jomb
         3vGruZb5HR9yJKmpM+5LAuT/r1QOPbSld6HeA2tyfmgoUf/Ox8QEOW+mLtEIRaWZ3HbL
         kptc1klOIGXNVvtJNo5YtgjIeN8R1Su6vLeY6+rUrY7iJ1o7ga9UlmuRRmREvQUGQOcy
         QT6EYx7Z8JNawT5vjwQ03DmLqHp9d3caD6jsm0Nxjtl+J7o49jkptkKO1utzeC4Gk2XJ
         RNnw==
X-Gm-Message-State: AO0yUKVSo12uuoSDqbWrAX+k9wOUHIReqoFgxOrG5GkQpjTWeNqvaXJo
        LCG0ar2AUzNZhuShDq8mOzPLWenMXgbPjmYvZ1w=
X-Google-Smtp-Source: AK7set9HaP/UPgY7K/TxVNqvBBfIPLs5pR7aMpTjNRzw/f+HmV5WnnNYXz0m5+NCwkjkyd+vOX+qBPBn/8SF/6QNv8A=
X-Received: by 2002:a62:ce87:0:b0:606:d488:f058 with SMTP id
 y129-20020a62ce87000000b00606d488f058mr5864753pfg.3.1678184505456; Tue, 07
 Mar 2023 02:21:45 -0800 (PST)
MIME-Version: 1.0
Reply-To: vandekujohmaria@outlook.com
Sender: congo2029@gmail.com
Received: by 2002:a05:6a21:8dc5:b0:cc:1c41:858f with HTTP; Tue, 7 Mar 2023
 02:21:44 -0800 (PST)
From:   Gerhardus Maria <vandekujohmaria@gmail.com>
Date:   Tue, 7 Mar 2023 10:21:44 +0000
X-Google-Sender-Auth: GkOdey-of5QSi38XOtTZhvEkW9k
Message-ID: <CAMe-s-KoPW-t3SXWrxG7dVyODoJsrwS_iTUdf+5J9aOEzbWLCQ@mail.gmail.com>
Subject: Best Regards
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello, how are you?  My name is van der kuil Johannes gerhardus Maria.
I am a lawyer from the Netherlands who reside in Belgium and I am
working on the donation file of my client, Mr. Bartos Pierre
Nationality of Belgium.  I would like to know if you will accept my
client's donation Mr. Bartos Pierre?

Waiting to hear from you soon
