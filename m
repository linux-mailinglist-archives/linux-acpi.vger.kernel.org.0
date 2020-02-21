Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E79167D90
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2020 13:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgBUMhB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Feb 2020 07:37:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:54162 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgBUMhA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Feb 2020 07:37:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 04:37:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,468,1574150400"; 
   d="scan'208";a="229839293"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga008.jf.intel.com with ESMTP; 21 Feb 2020 04:36:58 -0800
Date:   Fri, 21 Feb 2020 14:36:57 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
cc:     pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Subject: regression with ACPI: PM: s2idle: Prevent spurious SCIs from waking
 up the system
Message-ID: <alpine.DEB.2.21.2002211426350.2957@eliteleevi.tm.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

upon rebase of our ALSA/SOF subsystem tree to latest upstream, we started
hitting a lot of issues in our suspend tests on multiple platforms. 

On many CML and newer devices, system no longer wakes up from "rtcwake -m 
mem -s 10".

Original bug report and list of affected systems:
https://github.com/thesofproject/linux/issues/1815

I reproduced this on a CML laptop, did a bisect and this was rooted back 
to this commit:

fdde0ff8590b ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system

... so apparently acpi_any_gpe_status_set() is not true in this case.

Br, Kai
