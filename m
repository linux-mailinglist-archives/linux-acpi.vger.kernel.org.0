Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B39105C36
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 22:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfKUVqC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 16:46:02 -0500
Received: from mail1.tango.lu ([212.66.75.102]:50554 "EHLO mail.tango.lu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbfKUVqC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Nov 2019 16:46:02 -0500
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Nov 2019 16:46:00 EST
Received: from mail.tango.lu (localhost [127.0.0.1])
        by mail.tango.lu (Postfix) with ESMTP id 42D063833A1
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2019 22:36:25 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Nov 2019 22:36:25 +0100
From:   freebsd@tango.lu
To:     linux-acpi@vger.kernel.org
Subject: proc/acpi/event missing, plugging a new 5.3 kernel into an old system
Message-ID: <1651e619b8a955179e02f5dadd2e5677@tango.lu>
X-Sender: freebsd@tango.lu
User-Agent: Roundcube Webmail/1.2.0
X-Virus-Scanned: clamav-milter 0.99.4 at mail.tango.lu
X-Virus-Status: Clean
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello list,

I have a legacy debian 5.x server what I would like to keep that for 
various reasons but also use a new kernel. This is a KVM VM. My only 
issue with using a new kernel that it seems that this /proc/acpi/event 
interface was completely removed without the possibility to re enable it 
so I cannot do virsh shutdown <VM>.


This is needed (at least for the old acpid) to communicate.
Is there an unofficial patch which puts this interface back?

cat /boot/config-5.3.11 | grep -i acpi
CONFIG_X86_64_ACPI_NUMA=y
# Power management and ACPI options
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=m
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_NFIT is not set
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
# CONFIG_ACPI_APEI_EINJ is not set
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# end of Power management and ACPI options
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=y
CONFIG_PNPACPI=y
CONFIG_ATA_ACPI=y
# CONFIG_PATA_ACPI is not set
# ACPI INT340X thermal drivers
# end of ACPI INT340X thermal drivers
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_DMA_ACPI=y
