Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82940227442
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jul 2020 02:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgGUA6u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 20:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgGUA6t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jul 2020 20:58:49 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90504C0619D5
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2020 17:58:49 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g20so14096201edm.4
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2020 17:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGtVdD2nEWSAU113PZhe2hv5MHlPJH23JUncqOBeJY0=;
        b=TicxJRsOh8783t529jSJMRkr8y4Zm4nuwkyuwFnsrgdDNsMVT2C7K9phpWYq4cjyWm
         CdDaairVbrtCrkrqGloXb3Kg+Hpawv0IiLCSS152OiROfES0HHSP2mMQzr/Ps8oiN3eY
         WNK2DCgi7LnWBoTFMQV1rD0fzkoJOX8CrVyh2A6N29vL10OD7biyVAHgrQr42iIrFovz
         Ggquj7bwc6RV3JqohG9ufGn2KxwFFK3DV47wsxuS/3VWMiqvDSR/Sw1DPwcNebavbySE
         k/WS+LvuJE4mzyYbkpSta8GQzN9y1whu3KyWLJRt31b6FaohPVSI7h6bHR4sYIl0E6tR
         nKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGtVdD2nEWSAU113PZhe2hv5MHlPJH23JUncqOBeJY0=;
        b=aZeW5k/X70Et6moImIrWXFHk6xOwzFtBPMx10g9+fhH98WhXVaRqwBhVyT8MMILkdk
         9HfeMwYR87pY1+10yDG2VZFNjuBKlFRjBKXlqEWdKCGbabrDbRgQdMSSrHrG3xspILlN
         UKzALqk3YSvGWYtl7jfsIKMiyZlaOhsG4JSiV8ERN1dPMAWXDtuT2/VlI6NufWN/zjrN
         o3wyKvGIGNEHEMpssXzvYNxjaRH0CB7n7mbJxJgTMLUSt62wD0EUnuKkdt/Oe/WDQs26
         nIoFlfBYzqw7eCCv0f17nhpk/4bR7N4Ds7NzHG8uWDEBUNPMbVLS0l35i6JpyVLQ4azZ
         UM7w==
X-Gm-Message-State: AOAM530fbFT1MK8DsGIpsBT83M8/NajenK8yrOhiziq/inHIGe4I2gId
        d9ZtGiW+kumiMdoMEazxfeybYvcjuDNwlEd0+xLPuA==
X-Google-Smtp-Source: ABdhPJxgQp44bjFNJWLzBYp6Is2/AsTzZZ4zfxGj9e6W5uADSL3R+H2d1wy4qAl88PCnEMIe9kqHQ9N3Qt//tTMNVOc=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr24567303edo.102.1595293128192;
 Mon, 20 Jul 2020 17:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c825b5ee-ec03-7aa8-e380-6003f33fa113@infradead.org> <a6892924b53e8610753a13fa506099558f0efc6f.camel@intel.com>
In-Reply-To: <a6892924b53e8610753a13fa506099558f0efc6f.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 Jul 2020 17:58:37 -0700
Message-ID: <CAPcyv4hSs=yQmocOVa8S=6C_8=1DRa9Ba92PK4YsXRwndf3p=g@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation support
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pavel Machek <pavel@ucw.cz>, Ira Weiny <ira.weiny@intel.com>,
        Len Brown <len.brown@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 20, 2020 at 5:14 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> On Mon, 2020-07-20 at 17:02 -0700, Randy Dunlap wrote:
> > Hi Dan,
> >
> > Documentation comments below:
>
> Dan, Randy,
>
> I'm happy to fix these up when applying.

Sounds good. Thanks Vishal.
