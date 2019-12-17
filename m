Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA73E122930
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 11:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfLQKuD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 05:50:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:1450 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfLQKuC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Dec 2019 05:50:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 02:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="221735328"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.128])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2019 02:49:59 -0800
Date:   Tue, 17 Dec 2019 18:57:47 +0800
From:   Philip Li <philip.li@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     lkp <lkp@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [kbuild-all] Re: [pm:intel_idle+acpi 4/10]
 acpi_processor.c:undefined reference to `acpi_processor_ffh_cstate_probe'
Message-ID: <20191217105747.GF9122@intel.com>
References: <201912162148.hTRbNfPp%lkp@intel.com>
 <CAJZ5v0iTOSnvZqKuL7gy7QBtdHxcM7wPS8qdgbvs6+sQxZX5yg@mail.gmail.com>
 <831EE4E5E37DCC428EB295A351E66249522A215D@shsmsx102.ccr.corp.intel.com>
 <CAJZ5v0gFbjbqTOD845RjzpJQXQY=ko=9GxwVxoqw0fPccfig4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gFbjbqTOD845RjzpJQXQY=ko=9GxwVxoqw0fPccfig4w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 17, 2019 at 09:23:14AM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 17, 2019 at 1:31 AM Li, Philip <philip.li@intel.com> wrote:
> >
> > > Subject: [kbuild-all] Re: [pm:intel_idle+acpi 4/10] acpi_processor.c:undefined
> > > reference to `acpi_processor_ffh_cstate_probe'
> > >
> > > On Mon, Dec 16, 2019 at 2:26 PM kbuild test robot <lkp@intel.com> wrote:
> > > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> > > intel_idle+acpi
> > > > head:   dcedc03145600b929a32acb85b212131b079bc46
> > > > commit: 0300cf31f061e6287810c894337f29df2e200e2d [4/10] ACPI: processor:
> > > Export acpi_processor_evaluate_cst()
> > >
> > > Outdated.  Please stop sending these.
> > thanks for the input Rafael, we will ignore the following tests on it.
> 
> Well, the branch has been rebased since then and effectively it is a new one.
> 
> My point is that if something like that happens, the script should
> discard the old branch and pull the new one from scratch.
Got it, sorry for wrong understanding. We will add logic to judge the rebase
to reduce the later meaningless reports. Currently we only support the checking
of new patch set version in mailing list.
