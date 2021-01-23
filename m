Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7B30165A
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Jan 2021 16:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbhAWP1q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 23 Jan 2021 10:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbhAWP0D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Jan 2021 10:26:03 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A73CC06174A
        for <linux-acpi@vger.kernel.org>; Sat, 23 Jan 2021 07:25:23 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id x71so9620745oia.9
        for <linux-acpi@vger.kernel.org>; Sat, 23 Jan 2021 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JJ9AaeDi3h7Z48bh+8SEw8NsXJib/syupZxz2yDQAaE=;
        b=lMIUh/bCsPddT/k89LeQ5hdtjzreLuyKeJOOpMYcCutrbKqq6zql4LtGs90lwdFh+p
         sEQ4fSkD9whcvgwvsXk4lOquomnBS/V9esRi+/BLKRBGT4GTLqqGrWuE/P+Iv4SJeE1u
         AeTrIU0gNbg/8MOWKKnNoroz/giQkwy/vWhXmquA8baj3I7OKQS5HR8rlHaqVclIs//k
         OVDplBp+2u7/mT0Kt6SAIluuDsS/hjQln0963Fh39vzKDddR8YEU8I/5K0dw6Wknfhl1
         /oONhg4AIyx6exji0ENlBNfH3LSwtbVt6o6SapO4VrlKm5a7ososg17VKVj9Ahsd8+yu
         UaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JJ9AaeDi3h7Z48bh+8SEw8NsXJib/syupZxz2yDQAaE=;
        b=uNNpTuQ18mNQhoGrvoD+p8vFSk6oHpfs3x9QRZIYIJbeFzXeypWnMg4VymsCVFv1SL
         CHhKCl2ge0vwApLnxZ3fzIi0bqqF6RH7JjPUJ91g2xtkCDYD5Jc5ZkAGLsUJFz1cgENS
         PD9B17CWQ6fwtnjmKnKAunr2pv0/37SeeCRZH2ynOGlNHArMV89zaTqNwb80UX03U1BH
         vPS0du9AVRkfOqCjIMgf05gB9cBM1VLG0LSLQ5sYU4S7uCp7LY59+kaytOzbikbKLj+r
         5u6NETHX85ht3kupknvHaJBMxLvVOWlj9JIEohzp83QV0uJtHm5YvWSernRd0QlsAw3y
         k1fQ==
X-Gm-Message-State: AOAM532hx7u6P9fQ39Py3JzFZPDZs9T1FPA2rly2hzwvdlLAJh1VMQmh
        wPwYP7s5CaxW34gzqjsPKQs=
X-Google-Smtp-Source: ABdhPJy0/L6elhB8WUDdT9NjoXDmqcroLTVC9W2swMNgR86iiQQJ160agsnmVzuFieRKaNBBXr8dQA==
X-Received: by 2002:aca:5e42:: with SMTP id s63mr6507029oib.96.1611415522763;
        Sat, 23 Jan 2021 07:25:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a13sm456880otr.49.2021.01.23.07.25.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Jan 2021 07:25:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Jan 2021 07:25:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [v2,3/9] ACPICA: ACPICA: fix -Wfallthrough
Message-ID: <20210123152520.GA41373@roeck-us.net>
References: <20210122002357.370836-4-erik.kaneda@intel.com>
 <20210123152104.GA36465@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210123152104.GA36465@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jan 23, 2021 at 07:21:04AM -0800, Guenter Roeck wrote:
> On Thu, Jan 21, 2021 at 04:23:51PM -0800, Erik Kaneda wrote:
> > From: Nick Desaulniers <ndesaulniers@google.com>
> > 
> > ACPICA commit 4b9135f5774caa796ddf826448811e8e7f08ef2f
> > 
> > GCC 7.1 gained -Wimplicit-fallthrough to warn on implicit fallthrough,
> > as well as __attribute__((__fallthrough__)) and comments to explicitly
> > denote that cases of fallthrough were intentional. Clang also supports
> > this warning and statement attribute, but not the comment form.
> > 
> > Robert Moore provides additional context about the lint comments being
> > removed. They were for "an old version of PC-Lint, which we don't use
> > anymore." Drop those.
> > 
> > This will help us enable -Wimplicit-fallthrough throughout the Linux
> > kernel.
> > 
> > Suggested-by: Robert Moore <robert.moore@intel.com>
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > 
> > Link: https://github.com/acpica/acpica/commit/4b9135f5
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
> 
> With gcc 6.5 (and presumably each gcc version older than 7.1),
> this patch results in:
> 
> drivers/acpi/acpica/dscontrol.c: In function ‘acpi_ds_exec_begin_control_op’:
> drivers/acpi/acpica/dscontrol.c:65:3: error: ‘ACPI_FALLTHROUGH’ undeclared
> 
> and similar errors for other files.
> 

Wait, this differs from the patch in -next.

> > +#ifndef ACPI_FALLTHROUGH
> > +#define ACPI_FALLTHROUGH do {} while(0)

This line is missing in -next.

v2 doesn't say what changed in v2. Is that the change ?

Guenter
