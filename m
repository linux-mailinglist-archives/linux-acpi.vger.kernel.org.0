Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124E734D377
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhC2PNU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 11:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2PM5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 11:12:57 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1256FC061574
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 08:12:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id o16so2306888ljp.3
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 08:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5/8kk4ox/5Tuoi5bHBW9bZqDcQioEYzA8lrAMJq3ltE=;
        b=uOWhCu9fFToO3u2tAQ8s7WkJiYIalltX6kcl+M+KXueP0KFJCasSKZ1FaiiOzTQDm6
         MA8O3+zPTtSKLwG/scVTsghMZRHhbRvAv7JqJTzmhR4XVAWiSNqtY9K/b8myg7lgAj6/
         bdNSwZfJajFM3Lw5klMiZhK+GLZtQI/XPMST7FeeHDnS7pLBTZJChYXLBVDLAB3dsZno
         Ep+zLkBPXSfUZ/BhywBuDP6mx4VEKRPXLZbdXU9GOI7GoEE2HyRvC8S/NoiURjHqJDTm
         7ZA1a5FnaMr8o/+x6LFg92tPvcIPA0tPO/q/tpE+CGJgAJ/kLvF9H9Oe1jjRdTUxMC+T
         OmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5/8kk4ox/5Tuoi5bHBW9bZqDcQioEYzA8lrAMJq3ltE=;
        b=UJzCzcvQpMrpUmMoaqjVEZzzb6JZL/3g+fDlWFbZIsi7k8AOEMLTDrB+lX+LByNSu0
         FH4GbM3yX7fuZK9aA1im5ayDu6KURGxpXJe4SRpNa1/5AyMTEugWjb4ELZds9ppGj2UD
         QK1DTRigHaeUOEck8uD1wsuoF8YNcmHtwyf8lt5Z4bFG8hetRlXpWcHtmtjw2fGNwSc/
         3AAzyV/KqNecAhKveCKPYZ9bwoE5XX9QmhG64jdI2iNg6aocyPxyKS0i+ID29xoopJvh
         NEOFJwePBoTI61OSK+J8EfIPeu87BavW6hrTJGsvBH3WLz2KlN4dtakN+/PFzyrNKU7h
         1w2g==
X-Gm-Message-State: AOAM531emmEsBqp7iE35fMDMI5E10ph0LaqEJwZh9rAUKKUI52OfISAb
        BMa5dIvrdYejvsFmVJf4A6YJFbFPBKML4e7yKg==
X-Google-Smtp-Source: ABdhPJxtSOC+Ya4QZz2qD6q+7YBm1dwQwYFXqYeSmx5voyp6bbfQiz98WtdbZ+KzMBp5b84bsnXzCGuZzwodHbgOIMs=
X-Received: by 2002:a2e:9d8f:: with SMTP id c15mr18159942ljj.494.1617030775630;
 Mon, 29 Mar 2021 08:12:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:924a:0:0:0:0:0 with HTTP; Mon, 29 Mar 2021 08:12:55
 -0700 (PDT)
Reply-To: sgtmanthey1@gmail.com
From:   kayla manthey <agbedarichard@gmail.com>
Date:   Mon, 29 Mar 2021 15:12:55 +0000
Message-ID: <CA+2VjisP64TZA6bfu=ngFediY-79g0EN54B+Kg7ijQ4JN1iXrw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Vennligst jeg vil vite om du har mine tidligere meldinger.
