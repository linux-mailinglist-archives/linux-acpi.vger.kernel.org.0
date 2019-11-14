Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E684FC903
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfKNOgu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 09:36:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40287 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfKNOgt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2019 09:36:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id 22so5429537oip.7
        for <linux-acpi@vger.kernel.org>; Thu, 14 Nov 2019 06:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXJ+D6UpPbQWBLTJ7M1XVrpbzC7rh0dCOOBEp6gQIL0=;
        b=IRHQtHogA4m2uvVBzzBaT65ttDtSfS2JXjGszBBzZAxJxNwYrh2FxBX0cqa9ZWMgrc
         MpXpVbGUkAJWA/Q3kjawD6nOAZbbIhZVH+CY47WJj6JDKBvWmMzNHs5vvsI8Ay3mZ5zt
         +98LxIHC98+9Gx2i6RuvCaBsqMZBNd7fn0zNwFqsrgjR6HuXveG+3aajdlWcISz83GPm
         1LAhbJxYtTR0oIjrUZNWSpPIYVdDX9phCVvHyckHtfZs6p6hvfGnj5EIB9XpSCZYlvea
         HANcNG+RJzxJD48N+Av7VVqGdNsMDHNnsBy0bs55xyyOGGWf8bjOrMYTU6LQB6HKndpc
         /EqA==
X-Gm-Message-State: APjAAAUNPhFtVbtI0A87YlnGI0CWLFKnIJd5HAZHGXsEeG8MyExnfJxm
        N2P/hANkndjvIRQyaxk3nbKwInSkLrNOQommnSvAQA==
X-Google-Smtp-Source: APXvYqy3BuoaSuFSP66bzYjYYD0UfGChglC9Ys+P4vhtjHOC5En450PQlOlslOiTfSZ4LwViD556Lq5tDnWzFX9h0mY=
X-Received: by 2002:aca:c753:: with SMTP id x80mr3581576oif.115.1573742207134;
 Thu, 14 Nov 2019 06:36:47 -0800 (PST)
MIME-Version: 1.0
References: <b509514b-f831-4288-9852-25385da45c9c@www.fastmail.com>
In-Reply-To: <b509514b-f831-4288-9852-25385da45c9c@www.fastmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 15:36:36 +0100
Message-ID: <CAJZ5v0iZ9pR8ou95q2kQnawWWmuOqpnEivRVx4H12sa4FGveSg@mail.gmail.com>
Subject: Re: how to disable the "button" kernel module?
To:     Bruno Dantas <kernel@dantas.airpost.net>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 3:33 PM Bruno Dantas <kernel@dantas.airpost.net> wrote:
>
> I realize that "button" is a kernel built-in and therefore cannot be disabled via "blacklist=button" boot parameter. So I thought I'd try initcall_blacklist=<function> but I cannot find an obvious module initialization function in button.c
>
> Please, how would one disable the button module? I'm looking for a method that would not involve recompiling the kernel.

It definitely can be built as a module.

Why exactly do you want to disable it?
