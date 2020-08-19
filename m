Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA0E2492FF
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Aug 2020 04:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHSCrq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Aug 2020 22:47:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:15030 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgHSCrp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Aug 2020 22:47:45 -0400
IronPort-SDR: L6pEgruXE4aIiFCpbNo2xc1LQGzJPGqaQEjFiMwADumXCSP/Q5mwpN0k/Fy74MuNnGRvNbGiuT
 qBn0XIf6/Stw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="216562473"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="216562473"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 19:47:44 -0700
IronPort-SDR: HTPu3kc4NDfnQNpcql8xFm6h7Bcvs/ijovcCEMgk88lATFsD/VWz2NgT1MF8RUnPoQA28XFtl2
 q0wEHbI0ZNow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="320315331"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2020 19:47:43 -0700
Date:   Wed, 19 Aug 2020 10:48:58 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] ACPI: processor: Print more information when
 acpi_processor_evaluate_cst() failed
Message-ID: <20200819024858.GA25038@chenyu-office.sh.intel.com>
References: <20200816151230.14524-1-yu.c.chen@intel.com>
 <CAJZ5v0jz5EH7bB5Goia=qd_P5eVLoONbscSvvEAqU7svodg_MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jz5EH7bB5Goia=qd_P5eVLoONbscSvvEAqU7svodg_MA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 18, 2020 at 12:46:12PM +0200, Rafael J. Wysocki wrote:
> On Sun, Aug 16, 2020 at 5:12 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Some platforms have bogus _CST which might cause expectd behavior
> > in the cpu idle driver. Some bogus _CST might be unable to be
> > disassembled by acpica-tools due to broken format.
> > Print extra log if the _CST extraction/verification failed.
> > This can be used to help the user narrow down why the cpu
> > idle driver fails to behave as expected.
> >
> > Suggested-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> This is fine by me as a general idea, but please change the log level to "info".
>
Okay, I will send a new version. Thanks!

thanks,
Chenyu
