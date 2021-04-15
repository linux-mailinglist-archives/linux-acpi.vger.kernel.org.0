Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D6E3615BB
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Apr 2021 00:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhDOWyk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 18:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbhDOWyh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Apr 2021 18:54:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F6AC061756
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 15:54:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m3so29989956edv.5
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZPmXSJHlNJkGabrxCzQ+1bNVgcNhlvvFPZsThC87BQ=;
        b=0/Bv9AMjps8ZT69MpMit11F2p9twNVTVYb+XVv9QK0JxYFc5DvplRTa70eF1YbSfMu
         IBkP1v8RHWg08P2iK/miye29yig2XeDlud0R4CkYnz0EAOTuVpy+cX7jEx6dcHmdnzsC
         6DhGckcXW/uRc2ecX2R+QDWHPUPGMN2b7OZhI25TlWuDwO7+Y7BtCCGo+z1tHYpWubGh
         W6IOmdyWPbvgjU9ZxMQ2zo0MnTE+QTrwXHN2bNY/B/wuPeBSD8viT2PIlL34ggRpAtYF
         RFPmZfJFEWz3M/cDojI6+EXjosI04PgHYSlkQH/mCcaVIhycSv9J0ikMzMpmmbuP7qgb
         PPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZPmXSJHlNJkGabrxCzQ+1bNVgcNhlvvFPZsThC87BQ=;
        b=ZA/pMyzZtuxe85cBGiSacFFe2XyD3pp3FYr6cNQZZaD6Tq4Daa6u9vEtPNpgwJukD9
         kxNKJToK5hDnRVKhD3QpgiLmpRSIkRXqBj4vYr5HqpzbneBrvlQr33qPv2UoVTKpSK92
         7zy+2Qd2wMefHK++d6P9GD20cx0ildg772fXesi8XeY4JDt6U1sEa6UP7LpJIrlreC0l
         wZ6h6oCfessEYUrxWX7vDPW7uynCN0xiRskOxGV+0Qr5KWztjUQlha4ByIf+CwIGFyRk
         /nDalY1w6RFEzIaFDhioCWQ3txJqJ8jHfgWIkS9BoF/cpoKAULh755274drHxF3y4f5k
         7PNQ==
X-Gm-Message-State: AOAM532ElqIZHv5hzMqpRRdEbrFIkC3jrwkdV7gF5rA85IehxMSldqSl
        1/iEU6043iXEqiok5comDaZHQlcGEQQVKGX8m2ARLQ==
X-Google-Smtp-Source: ABdhPJz2afjkEzncwyQD1rDlPyo0Ht+aLitlIBNnnevfCO5TgZ+sU9A5sYUKn48QokZdzy1MDkhkJuwtfpo7kv0FJJg=
X-Received: by 2002:a50:e607:: with SMTP id y7mr7076665edm.18.1618527252572;
 Thu, 15 Apr 2021 15:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210407222625.320177-1-ben.widawsky@intel.com> <20210407222625.320177-7-ben.widawsky@intel.com>
In-Reply-To: <20210407222625.320177-7-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 15:54:00 -0700
Message-ID: <CAPcyv4huxaVj=Czk7KgbwfS=6_Dc_N3MmoN-=faB_hSuSt7u8w@mail.gmail.com>
Subject: Re: [PATCH 6/7] cxl/mem: Create a helper to setup device regs
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 7, 2021 at 3:26 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Memory devices have a list of required register regions within the
> register block, but this isn't required of all CXL components or
> devices. To make things more tidy, and allow for easily setting up other
> block types in this loop, the helper is introduced.

I don't understand the point of this or the organization choice.
cxl_setup_device_regs() *is* the core implementation so there
shouldn't be a "__" prefixed version wrapping it. I agree that some
users will not care that some of the device registers are not found,
but that won't be cxl_mem_setup_regs() making that call.
