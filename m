Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF1A136507
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2020 02:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgAJBtk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jan 2020 20:49:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgAJBtk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jan 2020 20:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p4QP4PbFBViC/IrJOD8s6DAAUObkiprHZ4ezrP5rzQc=; b=G+uSs+0rSmyXt63Zqlr3fcYDw
        yzCUKp3ycDsskmVEvt9m+o2W843J405vbd5g24KOcd1jZ2nBEBH8PqbF9t75hWbtaqU/hxzffPrGY
        H7ygacZixNl8ytRjocJALHiEX+rtUPCJv6hAkeH38mfqnVb7ZOzitL0wbXuDA3ZG4pRaz9gtjzepX
        d5l9gRUcH/uYakCTvWRYsg0nCJCT7EZVaRPipibIoxKkDGqjJxqLA1Ehc8Sk4CV9UwlPNZj31TUz5
        s5RYBUyiEJ47WfZZHbQfz+OX9uXfrk2OtVChH/ztxCs3YPYHcjEdDoWCqrGcfTI4/ltquDidDZDG8
        SBm917RrQ==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipjQg-0003AO-Qp; Fri, 10 Jan 2020 01:49:38 +0000
Subject: Re: [PATCH] Documentation: admin-guide: PM: Add intel_idle document
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux Documentation <linux-doc@vger.kernel.org>
References: <2011307.aCGEDdB8HR@kreacher>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d89dd544-77c9-4b80-d91f-c44fc2f83144@infradead.org>
Date:   Thu, 9 Jan 2020 17:49:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <2011307.aCGEDdB8HR@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 1/9/20 4:13 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add an admin-guide document for the intel_idle driver to describe
> how it works: how it enumerates idle states, what happens during the
> initialization of it, how it can be controlled via the kernel command
> line and so on.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> The document introduced by this patch matches the driver code behavior
> after the changes recently added to linux-next.
> 
> ---
>  Documentation/admin-guide/pm/intel_idle.rst    |  268 +++++++++++++++++++++++++
>  Documentation/admin-guide/pm/working-state.rst |    1 
>  2 files changed, 269 insertions(+)
> 
> Index: linux-pm/Documentation/admin-guide/pm/working-state.rst
> ===================================================================
> --- linux-pm.orig/Documentation/admin-guide/pm/working-state.rst
> +++ linux-pm/Documentation/admin-guide/pm/working-state.rst
> @@ -8,6 +8,7 @@ Working-State Power Management
>     :maxdepth: 2
>  
>     cpuidle
> +   intel_idle
>     cpufreq
>     intel_pstate
>     intel_epb
> Index: linux-pm/Documentation/admin-guide/pm/intel_idle.rst
> ===================================================================
> --- /dev/null
> +++ linux-pm/Documentation/admin-guide/pm/intel_idle.rst
> @@ -0,0 +1,268 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +==============================================
> +``intel_idle`` CPU Idle Time Management Driver
> +==============================================
> +
> +:Copyright: |copy| 2020 Intel Corporation
> +
> +:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> +
> +
> +General Information
> +===================
> +
> +``intel_idle`` is a part of the
> +:doc:`CPU idle time management subsystem <cpuidle>` in the Linux kernel
> +(``CPUIdle``).  It is the default CPU idle time management driver for the
> +Nehalem and later generations of Intel processors, but the level of support for
> +a particular processor model in it depends on whether or not it recognizes that
> +processor model and may also depend on information coming from the platform
> +firmware.  [To understand ``intel_idle`` it is necessary to know how ``CPUIdle``
> +works in general, so this is the time to get familiar with :doc:`cpuidle` if you
> +have not done that yet.]
> +
> +``intel_idle`` uses the ``MWAIT`` instruction to inform the processor that the
> +logical CPU executing it is idle and so it may be possible to put some of the
> +processor's functional blocks into low-power states.  That instruction takes two
> +arguments (passed in the ``EAX`` and ``ECX`` registers of the target CPU), the
> +first of which, referred to as a *hint*, can be used by the processor to
> +determine what can be done (for details refer to Intel Software Developer’s
> +Manual [1]_).  Accordingly, ``intel_idle`` refuses to work with processors in
> +which the support for the ``MWAIT`` instruction has been disabled (for example,
> +via the platform firmware configuration menu) or which do not support that
> +instruction at all.
> +
> +``intel_idle`` is not modular, so it cannot be unloaded, which means that the
> +only way to pass early-configuration-time parameters to it is via the kernel
> +command line.
> +
> +
> +.. _intel-idle-enumeration-of-states:
> +
> +Enumeration of Idle States
> +==========================
> +
> +Each ``MWAIT`` hint value is interpreted by the processor as a license to
> +reconfigure itself in a certain way in order to save energy.  The processor
> +configurations (with reduced power draw) resulting from that are referred to
> +as C-states (in the ACPI terminology) or idle states.  The list of meaningful
> +``MWAIT`` hint values and idle states (i.e. low-power configurations of the
> +processor) corresponding to them depends on the processor model and it may also
> +depend on the configuration of the platform.
> +
> +In order to create a list of available idle states required by the ``CPUIdle``
> +subsystem (see :ref:`idle-states-representation` in :doc:`cpuidle`),
> +``intel_idle`` can use two sources of information: static tables of idle states
> +for different processor models included in the driver itself and the ACPI tables
> +of the system.  The former are always used if the processor model at hand is
> +recognized by ``intel_idle`` and the latter are used if that is required for
> +the given processor model (which is the case for all server processor models
> +recognized by ``intel_idle``) or if the processor model is not recognized.
> +
> +If the ACPI tables are going to be used for building the list of available idle
> +states, ``intel_idle`` first looks for a ``_CST`` object under one of the ACPI
> +objects corresponding to the CPUs in the system (refer to the ACPI specification
> +[2]_ for the description of ``_CST`` and its output package).  Because the
> +``CPUIdle`` subsystem expects that the list of idle states supplied by the
> +driver will be suitable for all of the CPUs handled by it and ``intel_idle`` is
> +registered as the ``CPUIdle`` driver for all of the CPUs in the system, the
> +driver looks for the first ``_CST`` object returning at least one valid idle
> +state description and such that all of the idle states included in its return
> +package are of the FFH (Functional Fixed Hardware) type, which means that the
> +``MWAIT`` instruction is expected to be used to tell the processor that it can
> +enter one of them.  The return package of that ``_CST`` is then assumed to be
> +applicable to all of the other CPUs in the system and the idle state
> +descriptions extracted from it are stored in a preliminary list of idle states
> +coming from the ACPI tables.  [This step is skipped if ``intel_idle`` is
> +configured to ignore the ACPI tables; see `below <intel-idle-parameters_>`_.]
> +
> +Next, the first (index 0) entry in the list of available idle states is
> +initialized to represent a "polling idle state", which means that its
> +``->enter()`` routine executes a special "pause" sequence of instructions in a
> +tight loop (it is a pseudo-idle state in which the target CPU continuously
> +fetches and executes instructions), and the subsequent (real) idle state entries
> +are populated as follows.
> +
> +If the processor model at hand is recognized by ``intel_idle``, there is a
> +(static) table of idle state descriptions for it in the driver.  In that case,
> +the "internal" table is the primary source of information on idle states and all
> +of the entries from it (that are not marked as "unusable" after applying quirks
> +and the number of ``MWAIT`` substates for them is not zero; see
> +`below <intel-idle-initialization-and-quirks_>`_) are copied to the final list
> +of available idle states.  If using the ACPI tables for the enumeration of idle
> +states is not required (depending on the processor model), all of them are
> +enabled by default (so all of them will be taken into consideration by
> +``CPUIdle`` governors during CPU idle state selection).  Otherwise, the idle
> +states specifically marked as the ones that should be always enabled by default
> +are enabled by default and for each of the other idle states the ``MWAIT`` hint
> +included in its description is compared with the ``MWAIT`` hints in the
> +preliminary list of idle states coming from the ACPI tables.  If there is a
> +match (i.e. one of the ``MWAIT`` hint values exposed by the platform firmware is
> +equal to the given idle state's ``MWAIT`` hint), the given idle state will be
> +enabled by default.  If that is not the case, it will be disabled initially, but
> +user space will be able to enable it later (on a per-CPU basis) with the help of
> +the ``disable`` idle state attribute in ``sysfs`` (see
> +:ref:`idle-states-representation` in :doc:`cpuidle`).  This basically means that
> +the idle states "known" to the driver are enabled by default if they have
> +also been exposed by the platform firmware (through the ACPI tables) or if they
> +are specifically marked to be always enabled by default.
> +
> +If the given processor model is not recognized by ``intel_idle``, but it
> +supports ``MWAIT``, the preliminary list of idle states coming from the ACPI
> +tables is used for building the final list that will be supplied to the
> +``CPUIdle`` core during driver registration.  For each idle state in that list,
> +the description, ``MWAIT`` hint and exit latency are copied to the corresponding
> +entry in the final list of idle states.  The name of the idle state represented
> +by it (to be returned by the ``name`` idle state attribute in ``sysfs``) is
> +"CX_ACPI", where X is the index of that idle state in the final list (note that
> +the minimum value of X is 1, because 0 is reserved for the "polling" state), and
> +its target residency is based on the exit latency value.  Specifically, for
> +C1-type idle states the exit latency value is also used as the target residency
> +(for compatibility with the majority of the "internal" tables of idle states for
> +various processor models recognized by ``intel_idle``) and for the other idle
> +state types (C2 and C3) the target residency value is 3 times the exit latency
> +(again, that is because it reflects the target residency to exit latency ratio
> +in the majority of cases for the processor models recognized by ``intel_idle``).
> +All of the idle states in the final list are enabled by default in this case.
> +
> +
> +.. _intel-idle-initialization-and-quirks:
> +
> +Initialization
> +==============
> +
> +The initialization of ``intel_idle`` starts with checking if the kernel command
> +line options forbid the use of the ``MWAIT`` instruction.  If that is the case,
> +an error code is returned right away.
> +
> +The next step is to check whether or not the processor model is known to the
> +driver, which determines the idle states enumeration method (see
> +`above <intel-idle-enumeration-of-states_>`_), and whether or not the processor
> +supports ``MWAIT`` (the initialization fails if that is not the case).  Then,
> +the ``MWAIT`` support in the processor is enumerated through ``CPUID`` and the
> +driver initialization fails if the level of support is not as expected (for
> +example, if the total number of ``MWAIT`` substates returned is 0).
> +
> +Next, if the driver is not configured to ignore the ACPI tables (see
> +`below <intel-idle-parameters_>`_), the idle states information provided by the
> +platform firmware is extracted from them.
> +
> +Then, ``CPUIdle`` device objects are allocated for all CPUs, quirks are applied
> +to the "internal" idle states table matching the given processor model (if it is
> +recognized by the driver) and the list of idle states is created (see
> +`above <intel-idle-enumeration-of-states_>`_).
> +
> +The quirks are needed in the cases when the same "internal" table of idle states
> +is used for multiple processor models and some of those idle states may not be
> +supported in some processor configurations (in which case, if the affected
> +processor configuration is detected, the idle states in question are marked
> +as "unusable") or the list of idle states to use depends on the number of
> +processor sockets in the system.  There is also a special way to obtain the
> +exit latency value for some idle states of Broxton processors that can be used
> +for updating the "internal" idle states table before using it for the
> +enumeration of idle states.
> +
> +Next, ``intel_idle`` is registered with the help of cpuidle_register_driver() as
> +the ``CPUIdle`` driver for all CPUs in the system and a CPU online callback for
> +configuring individual CPUs is registered via cpuhp_setup_state(), which (among
> +other things) causes the callback routine to be invoked for all of the CPUs
> +present in the system at that time (each CPU executes its own instance of the
> +callback routine).  That routine registers a ``CPUIdle`` device for the CPU
> +running it and if the processor model is recognized by ``intel_idle``, it
> +modifies the model-specific registers (MSRs) of that CPU in order to disable
> +auto-demotion of idle states or auto-promotion to the ``C1E`` idle state (or
> +both) if that needs to be done for the processor model at hand.
> +
> +
> +.. _intel-idle-parameters:
> +
> +Kernel Command Line Options and Module Parameters
> +=================================================
> +
> +The *x86* architecture support code recognizes three kernel command line
> +options related to CPU idle time management: ``idle=poll``, ``idle=halt``,
> +and ``idle=nomwait``.  If any of them is present in the kernel command line, the
> +``MWAIT`` instruction is not allowed to be used, so the initialization of
> +``intel_idle`` will fail.
> +
> +Apart from that there are two module parameters recognized by ``intel_idle``
> +itself that can be set via the kernel command line (they cannot be updated via
> +sysfs, so that is the only way to set them).
> +
> +The ``max_cstate`` parameter value is the maximum idle state index in the list
> +of idle states supplied to the ``CPUIdle`` core during the registration of the
> +driver.  It is also the maximum number of regular (non-polling) idle states that
> +can be used by ``intel_idle``, so the enumeration of idle states is terminated
> +after finding that number of usable idle states (the other idle states that
> +potentially might have been used if ``max_cstate`` had been greater are not
> +taken into consideration at all).  Setting ``max_cstate`` can prevent
> +``intel_idle`` from exposing idle states that are regarded as "too deep" for
> +some reason to the ``CPUIdle`` core, but it does so by making them effectively
> +invisible until the system is shut down and started again which may not always
> +be desirable.  In practice, it is only really necessary to do that if the idle
> +states in question cannot be enabled during system startup, because in the
> +working state of the system the CPU power management quality of service (PM
> +QoS) feature can be used to prevent ``CPUIdle`` from touching those idle states
> +even if they have been enumerated (see :ref:`cpu-pm-qos` in :doc:`cpuidle`).
> +Setting ``max_cstate`` to 0 causes the ``intel_idle`` initialization to fail.
> +
> +The ``noacpi`` parameter (which is recognized if the kernel has been configured
> +with ACPI support) can be used to make ``intel_idle`` ignore the system's ACPI
> +tables (which is the case if that parameter is equal to 1).

Where is this "noacpi" parameter?  Is this an intel_idel param?  I see
libata.noacpi and pci=noacpi but nothing like this for intel_idle.

Also, the wording is a little confusing.  What does it mean "if that parameter is equal
to 1"?  It's basically a word that is entered without a value AFAICT.


> +
> +
> +.. _intel-idle-core-and-package-idle-states:
> +
> +Core and Package Levels of Idle States
> +======================================
> +
> +Typically, in a processor supporting the ``MWAIT`` instruction there are (at
> +least) two levels of idle states (or C-states).  One level, referred to as
> +"core C-states", covers individual cores in the processor, whereas the other
> +level, referred to as "package C-states", covers the entire processor package
> +and it may also involve other components of the system (GPUs, memory
> +controllers, I/O hubs etc.).
> +
> +Some of the ``MWAIT`` hint values allow the processor to use core C-states only
> +(most importantly, that is the case for the ``MWAIT`` hint value corresponding
> +to the ``C1`` idle state), but the majority of them give it a license to put
> +the target core (i.e. the core containing the logical CPU executing ``MWAIT``
> +with the given hint value) into a specific core C-state and then (if possible)
> +to enter a specific package C-state at the deeper level.  For example, the
> +``MWAIT`` hint value representing the ``C3`` idle state allows the processor to
> +put the target core into the low-power state referred to as "core ``C3``" (or
> +``CC3``), which happens if all of the logical CPUs (SMT siblings) in that core
> +have executed ``MWAIT`` with the ``C3`` hint value (or with a hint value
> +representing a deeper idle state), and in addition to that (in the majority of
> +cases) it gives the processor a license to put the entire package (possibly
> +including some non-CPU components such as a GPU or a memory controller) into the
> +low-power state referred to as "package ``C3``" (or ``PC3``), which happens if
> +all of the cores have gone into the ``CC3`` state and (possibly) some additional
> +conditions are satisfied (for instance, if the GPU is covered by ``PC3``, it may
> +be required to be in a certain GPU-specific low-power state for ``PC3`` to be
> +reachable).
> +
> +As a rule, there is no simple way to make the processor use core-level C-states
> +only if the conditions for entering the corresponding package C-states are met,
> +so the logical CPU executing ``MWAIT`` with a hint value that is not core-level
> +only (like for ``C1``) must always assume that this may cause the processor to
> +enter a package C-state.  That is why the exit latency and target residency
> +values corresponding to the majority of ``MWAIT`` hint values in the "internal"
> +tables of idle states in ``intel_idle`` reflect the properties of package
> +C-states.  If using package C-states is not desirable at all, either
> +:ref:`PM QoS <cpu-pm-qos>` or the ``max_cstate`` module parameter of
> +``intel_idle`` described `above <intel-idle-parameters_>`_ must be used to
> +restrict the range of permissible idle states to the ones with core-level only
> +``MWAIT`` hint values (like ``C1``).
> +
> +
> +References
> +==========
> +
> +.. [1] *Intel® 64 and IA-32 Architectures Software Developer’s Manual Volume 2B*,
> +       https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-vol-2b-manual.html
> +
> +.. [2] *Advanced Configuration and Power Interface (ACPI) Specification*,
> +       https://uefi.org/specifications
> 
> 
> 

drop ending blank lines....

This contains lots of good info, but I don't see all of it as admin-guide/ material.
Lots of it is driver-development info, not admin info.  IMHO.

Anyway:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


thanks.
-- 
~Randy

