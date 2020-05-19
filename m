Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D91D9BEB
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgESQDi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 May 2020 12:03:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:45832 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgESQDh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 May 2020 12:03:37 -0400
IronPort-SDR: IgvqnSkXSR4Awa/tcl8nFcoHlsy5CQlqiGyBywmzZziT9tvw0+vR5KFuZI4phqEWubDYgADmFY
 5felWYtiiusA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 09:03:36 -0700
IronPort-SDR: fWovSdDswM66AcZN6edBdprpQo/g/swtmfnojYgrnPQHHmWpH8wQSNcdzQ5OlY0Xubw7IOxOQo
 +lHSZcut863g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="411683296"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 19 May 2020 09:03:36 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 87C905803C5;
        Tue, 19 May 2020 09:03:36 -0700 (PDT)
Message-ID: <d0022af356cf9bd5b544187d9a396734d85a76b3.camel@linux.intel.com>
Subject: Re: Low Latency Tolerance preventing Intel Package from entering
 deep sleep states
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "larsh@apache.org" <larsh@apache.org>,
        "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Date:   Tue, 19 May 2020 09:03:36 -0700
In-Reply-To: <2952287.p5mUHPKNZq@kreacher>
References: <1505028180.591737.1589564161284.ref@mail.yahoo.com>
         <1505028180.591737.1589564161284@mail.yahoo.com>
         <CAHp75VfC0NdyyR1zXbk47G_9y5ResrpV+w3cOntDqP_naocuvQ@mail.gmail.com>
         <2952287.p5mUHPKNZq@kreacher>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> > > Does anybody know what's going on or how to debug this further?
> > > As stated above, I was able to work around this problem by
> > > ignoring SOUTHPORT_A via /sys/kernel/debug/pmc_core/ltr_ignore.
> > > There has to be a better way, and I'm sure I'm not the only one
> > > running into this.

ltr_show shows the PMC's (Power Management Controller) view of SoC
devices and busses. The SOUTHPORTs are the PCIe root ports on your
system. When you run lspci they are the PCI bridges. Generally, the
bridges are enumerated in the same order as the SOUTHPORTs, so
SOUTHPORT_A is your first bridge and the device attached to it (shown
in lspci -t) is the device that was blocking deeper PC states according
to your debug.

Determine what this device is on your system. If the ltr was low it's
because that is what the device requested. You should first check that
runtime pm is enabled for the device. To do this, check the control
file in /sys/bus/pci/devices/<SSSS:BB:DD.F>/power, where SSSS:BB:DD.F
is the enumeration of your device as shown in lspci. If it is 'on' then
runtime pm is disabled. To enable it echo 'auto' into the file with
root privileges. Enabling runtime pm should allow the driver to reduce
functionality of the device when idle. This should lead to a larger
latency request on the PCI bus which should be reflected in ltr_show.
You can see if the device is actually runtime suspended and how much
time it's been suspended (or active) by reading the associated files in
the power folder.

If this doesn't work, then it's possible that your device doesn't
support runtime pm. This may be purposely for reliability reasons or
the driver may just lack support. Check forums discussing issues with
the device and look for possible options in the driver to force pm
support (generally this will be centered around enabling ASPM).

You can also download powertop to see the package c-state residencies
more clearly as percentages of time. powertop also has a tunables tab
that will show the status of runtime pm on all devices on the system
and allow you to enable them individually.

David

