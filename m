Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E941169B06
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2020 00:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgBWX5i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 23 Feb 2020 18:57:38 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:45954 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgBWX5i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Feb 2020 18:57:38 -0500
Received: by mail-ot1-f47.google.com with SMTP id 59so7135264otp.12;
        Sun, 23 Feb 2020 15:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ai/3b1qaSLbdV53wvmoNfCvPze83LtMRPjfisyynMg4=;
        b=C1CmNdM6NfG3nzLSVMnjMF/+EGQGDeplcZVSkHQnryp67pBWVTsnE38e0uN121cV66
         gi5gmWAI7whTq9+9oi6ql+uQgU+0migS/Txvh7DtIPygYzXJBg0b7KvdXkEZuj4Ka124
         dM/G9z0Jx17EcGHr8Mncm7sn/Th4ZfRZh+9PqiDN5zIePVIcKR4CcCXQikogRAXOOE2D
         fNI4n8rT0D0CHkivYMFjPE8Ud6TsBL8pe1Ppei8U0LXlUREv2k1zJLKhY9+r/ofg8T61
         ySbJfFpN2596eMCCqv9oWB+ClRzb4A9M9vIO0pNKVdnbdHlZssXQoNS7hsZ3nbAuOaq+
         zU3g==
X-Gm-Message-State: APjAAAWEuRMn5nn8JvCOQ4E0JCymZkGVCzDcxDm/FXwp+rdyiVO/qVyd
        FSMUnl+omAUgP4mDs55QgbaXYYbc0lOagsST75k=
X-Google-Smtp-Source: APXvYqxgn2ezY0c7O85EZeRyouHtRjAXdh/bIeYVOy2BpACjgbBbIrGMsiGbmRi2f3pjj95SI7nyzYK0QZ5UL2QX0W4=
X-Received: by 2002:a9d:7653:: with SMTP id o19mr36497772otl.118.1582502257480;
 Sun, 23 Feb 2020 15:57:37 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <158197497594.2449.9692451182044632969@skylake-alporthouse-com>
 <10791544.HYfhKnFLvn@kreacher> <4974198.mf5Me8BlfX@kreacher>
 <158227678951.3099.15076882205129643027@skylake-alporthouse-com>
 <CAJZ5v0h07em8y5bXcnUTBcjie8pCttADK9QX9W_cB0WQRcDfGQ@mail.gmail.com> <CAHk-=wihfx015Rr-nrMmBtN--357cFRbS4rjXeKXvEfB=GYT5g@mail.gmail.com>
In-Reply-To: <CAHk-=wihfx015Rr-nrMmBtN--357cFRbS4rjXeKXvEfB=GYT5g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Feb 2020 00:57:22 +0100
Message-ID: <CAJZ5v0gqu5DnfTFNnG2YiMwWRHZc_6ZHRiExrukBMYoTwo5ubg@mail.gmail.com>
Subject: Re: Linux 5.6-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 21, 2020 at 7:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Feb 21, 2020 at 2:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > Please pick up this patch directly if you can.
>
> Done. Added Chris' tested-by too.

Thank you!
