Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6FB28E6B8
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbgJNSwd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389252AbgJNSwb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2020 14:52:31 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A320AC0613D2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2020 11:52:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h6so640954lfj.3
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2020 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ea58qKonMZ+zepzsR2xAiE+MgtpRXlTME0hK3xVsjQ=;
        b=IFb1zks8vuF3XRjUSmADx7e+bVmtKHTmlQ+xKjmszgDcoFm1cXVR0SQ63/oSB2AKq3
         8/+YORXzioGoI60sXYgwD0VyGc5N51cleBaHgx9qdihjEB2tQYvfF4KLE5Z9LVTyIIn/
         Z7xsEvihhcW1dHlOu63rstkWL/3NxlGNguk5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ea58qKonMZ+zepzsR2xAiE+MgtpRXlTME0hK3xVsjQ=;
        b=G+VQ7lBOT+3NoF4MLXmxvmbz66kzvxDeHYPFqL4QYv2OVXHHUXgr/ynmvb9V6eo74P
         CgVMofjmxkMqqd7xkTXdDjyHkIWU7BHxOHCSp+qrjKT3G0XZwoZ0jBvGY+4ojo4JIJe/
         KjYQpm03BEVyGaFfIQsuVxzeb3g/xpPbrTrnQZSX+nw32yddkeOQ7h0wb7aYHtcGRoZK
         fJcfuSxaHLwfAuGDqnNWqceI3EFbCOqLnupwbQuu5ng2Ecl63c6uAS6ZpyWTRWoNzFLQ
         YLEePGcZo/H2e27e2neU3WTungEpAxFf0sfZ8tn+F2WsvG7cD91aDtHF8ssdNVNdiMqL
         kOlg==
X-Gm-Message-State: AOAM5324AoGO9HzXN3EUdT2j3WRsdfSxPuYY4TCvreUNgws+c0azD5jz
        Uk4alEmzZdpoqNC2v16WIVyB7G75ZQGZPg==
X-Google-Smtp-Source: ABdhPJztFLAIrEteuFQHtqQUquO3E0p1EgZEoesp4HaXBBkihVHIJzRFW/j5LkCzq73HhiU6f4+ymg==
X-Received: by 2002:a05:6512:3692:: with SMTP id d18mr215061lfs.203.1602701547745;
        Wed, 14 Oct 2020 11:52:27 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id n2sm54723lfa.24.2020.10.14.11.52.26
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 11:52:26 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id b1so585049lfp.11
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2020 11:52:26 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr210024lfa.603.1602701546151;
 Wed, 14 Oct 2020 11:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
In-Reply-To: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 11:52:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicsjwDrwRzD5g7YKAnWL+-5LYFr0BqDx873vMcgkS47w@mail.gmail.com>
Message-ID: <CAHk-=wicsjwDrwRzD5g7YKAnWL+-5LYFr0BqDx873vMcgkS47w@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI updates for v5.10-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 13, 2020 at 10:34 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> ACPI updates for 5.10-rc1.

So these clashed with Andrew's patches that I merged earlier
(particularly commit c01044cc8191: "ACPI: HMAT: refactor
hmat_register_target_device to hmem_register_device").

I think I sorted it out right, but it might be best to double-check my
end result.

               Linus
