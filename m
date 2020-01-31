Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 126D214EBA9
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2020 12:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgAaLY3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jan 2020 06:24:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:31212 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgAaLY3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jan 2020 06:24:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 03:24:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; 
   d="scan'208";a="218585313"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 31 Jan 2020 03:24:28 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.148])
        by linux.intel.com (Postfix) with ESMTP id A121A580277;
        Fri, 31 Jan 2020 03:24:25 -0800 (PST)
Message-ID: <28a92577c83276baf355dc8de272a79dc854025a.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] intel_idle: Introduce 'states_off' module parameter
From:   Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reply-To: artem.bityutskiy@linux.intel.com
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Jan 2020 13:24:24 +0200
In-Reply-To: <86fb1cd10e344f76a3e96c4b6c722680@AcuMS.aculab.com>
References: <1720216.0Jr2BLnqKp@kreacher> <16995896.bQtfYxEEOs@kreacher>
         <86fb1cd10e344f76a3e96c4b6c722680@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2020-01-31 at 11:07 +0000, David Laight wrote:
> Unless you know exactly which cpu table is being used the
> only constraint a user can request is the latency.

Hi David,

in all my use-cases I always know what is the CPU I am dealing with and
what are the C-states. Simply because in my view they are always CPU-
dependent in terms of what they do and how are they named.

What you say sounds to me like you would want to disable some C-states
without knowing anything (or much) about the CPU you are dealing with
and the C-state names.

If so, could you please share examples of such use-cases?

Thanks!

-- 
Best Regards,
Artem Bityutskiy

