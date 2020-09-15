Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6C26AF75
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 23:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgIOVVl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 17:21:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:28756 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbgIOVUf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Sep 2020 17:20:35 -0400
IronPort-SDR: f8NHnWMX1O33VTm7sKyJB3aTB4FPR/+QAzPt4vKGb4+gcP9MLffjxtZRIlwwsQWfUMM4wSO60K
 HDh2IQxULQyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="160283133"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="160283133"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 14:19:50 -0700
IronPort-SDR: 5he6km/6lWMs12kwE0KT/d5duW+O2FupTX1dLWYbGaty065qvt2xskpcHAiYRRiIkkA+VXrVWY
 UVbFx4sho3tQ==
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="343657747"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 14:19:50 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 2BB536369;
        Tue, 15 Sep 2020 14:19:50 -0700 (PDT)
Date:   Tue, 15 Sep 2020 14:19:50 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: Add Driver to set up lid GPEs on MS
 Surface device
Message-ID: <20200915211950.GL103884@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200908171934.1661509-1-luzmaximilian@gmail.com>
 <20200911221053.GF103884@mtg-dev.jf.intel.com>
 <e6125bee-d42e-f485-295a-8b9ad6777d4a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6125bee-d42e-f485-295a-8b9ad6777d4a@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 12, 2020 at 12:46:30AM +0200, Maximilian Luz wrote:
> On 9/12/20 12:10 AM, mark gross wrote:
> > Surface devices are tablets with detachable keyboards.  they don't really
> > have a "lid" as the tablet is the "lid".
> 
> The Surface Laptop series doesn't have a detachable keyboard, yet still
> requires this. Arguably, the Surface Books are also more laptop than
> tablet (at least that's the way I use mine...). Finally, on the actual
> tablets (Surface Pro series) the lid switch detects when the keyboard
> cover is opened (or at least that's what I have been told, I don't
> own/have access to a Pro series device).
> 
> Regardless of that, this patch is intended to provide the same behavior
> as found on Windows, for all devices included in this patch, which is:
> When you open the lid, or in case of the Pro series fold away the
> keyboard cover, the device wakes from suspend/s2idle. Without this
> patch, that doesn't work.
> 
> > I'm just questioning if the creator of the device designed it the way they did
> > maybe we should think twice about doing this.
> 
> As far as I can tell, the intended behavior is to wake the device when
> the lid is opened, which on the Laptops and Books is a more conventional
> lid and on the Pros constitutes opening the cover.
> 
> I'm open for any alternative though.
> 
> Also please note that I've already sent a v2 of this patch with Andy's
> comments addressed: https://lore.kernel.org/patchwork/patch/1303997/
never mind then.
--mark

