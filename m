Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5B437BE72
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 15:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhELNps (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 09:45:48 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:35661 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNps (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2021 09:45:48 -0400
Received: by mail-oi1-f171.google.com with SMTP id v22so17405575oic.2;
        Wed, 12 May 2021 06:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lA8i0U+g5mACLU+eRbepSsD3Oo1bI0QIPFtyWaxOugE=;
        b=BDMHXHfv9xPDlkvydZe3GzBw/yPh0KNSOO1M2JnJPMNoeYgTElwBCrjtU3uGvpgaSD
         D7lANRl+CcOGSm9CUzDI1glp93+qyShW4k3CGKEstardJvE7dmfeiOor18flbca1wsse
         yOVr66b0Z8BDMPwVDAES8hwshwK5ITOvlfBbWiM5tHFH0jRnG8h8P0xfmyT/8Bs4JDXJ
         ZOa2UD3uRxaw9TtW+1Nmp1oBSLGogiARB/TI4PsfUKFFVgMiTyLq11mITAQAa++zOmJ+
         rmS/9uWI27ao2RTOyXoqGqdVrLddSBOpjmOPstNNXk0bOhxMLdck/DNY84nMEeYN9UVa
         Desw==
X-Gm-Message-State: AOAM531jO5BNaYaOc9u82Aa+QZk357K/iQEuhlEtMM0WALjyt6LQm0SO
        Phiw6JJlbe3GGiiTnHhs4OW88qSEC4N+Z5SfqTV0ibmM
X-Google-Smtp-Source: ABdhPJzPc5bvW+wcDuELS7xHkhDTaVSoTqhrypJkxljml/hk568RV7QAdXvY/qoG5FdUestJhdac7mCJYmaGkqKbSTo=
X-Received: by 2002:aca:380a:: with SMTP id f10mr7732038oia.157.1620827078879;
 Wed, 12 May 2021 06:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210511180142.28472-1-sumeet.r.pawnikar@intel.com> <4754266321f71d4910c2a6167e92fea6a1462813.camel@intel.com>
In-Reply-To: <4754266321f71d4910c2a6167e92fea6a1462813.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 May 2021 15:44:27 +0200
Message-ID: <CAJZ5v0iWfL_W6ef5ikoQoehP7B8VP-zpjYWtpA5m4oiBW_1ipA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PM: Add ACPI ID of Alder Lake Fan
To:     Zhang Rui <rui.zhang@intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 12, 2021 at 6:33 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Tue, 2021-05-11 at 23:31 +0530, Sumeet Pawnikar wrote:
> > Add a new unique fan ACPI device ID for Alder Lake to
> > support it in acpi_dev_pm_attach() function.
> >
> > Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
>
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Applied as 5.13-rc material, thanks!
