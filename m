Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2418720B71F
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 19:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFZReT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jun 2020 13:34:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56028 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgFZReS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2020 13:34:18 -0400
Received: from 89-64-83-223.dynamic.chello.pl (89.64.83.223) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id aea2085616e28395; Fri, 26 Jun 2020 19:34:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Williams <dan.j.williams@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
Subject: [RFT][PATCH v3 0/4] ACPI: ACPICA / OSL: Avoid unmapping ACPI memory inside of the AML interpreter
Date:   Fri, 26 Jun 2020 19:28:27 +0200
Message-ID: <2788992.3K7huLjdjL@kreacher>
In-Reply-To: <2713141.s8EVnczdoM@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <2713141.s8EVnczdoM@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On Monday, June 22, 2020 3:50:42 PM CEST Rafael J. Wysocki wrote:
> Hi All,
> 
> This series is to address the problem with RCU synchronization occurring,
> possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
> when the namespace and interpreter mutexes are held.
> 
> Like I said before, I had decided to change the approach used in the previous
> iteration of this series and to allow the unmap operations carried out by 
> acpi_ex_system_memory_space_handler() to be deferred in the first place,
> which is done in patches [1-2/4].

In the meantime I realized that calling syncrhonize_rcu_expedited() under the
"tables" mutex within ACPICA is not quite a good idea too and that there is no
reason for any users of acpi_os_unmap_memory() in the tree to use the "sync"
variant of unmapping.

So, unless I'm missing something, acpi_os_unmap_memory() can be changed to
always defer the final unmapping and the only ACPICA change needed to support
that is the addition of the acpi_os_release_unused_mappings() call to get rid
of the unused mappings when leaving the interpreter (module the extra call in
the debug code for consistency).

So patches [1-2/4] have been changed accordingly.

> However, it turns out that the "fast-path" mapping is still useful on top of
> the above to reduce the number of ioremap-iounmap cycles for the same address
> range and so it is introduced by patches [3-4/4].

Patches [3-4/4] still do what they did, but they have been simplified a bit
after rebasing on top of the new [1-2/4].

The below information is still valid, but it applies to the v3, of course.

> For details, please refer to the patch changelogs.
> 
> The series is available from the git branch at
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpica-osl
> 
> for easier testing.

Also the series have been tested locally.

Thanks,
Rafael



