Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DCC151796
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2020 10:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgBDJRK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Feb 2020 04:17:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:49366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgBDJRK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Feb 2020 04:17:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE908AC65;
        Tue,  4 Feb 2020 09:17:08 +0000 (UTC)
Date:   Tue, 4 Feb 2020 10:17:07 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-acpi@vger.kernel.org
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Note about acpi_get_table_header
Message-ID: <20200204101707.30eaa5bb@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

The description block before acpi_get_table_header() in
drivers/acpi/acpica/tbxface.c includes the following comment:

 * NOTE:        Caller is responsible in unmapping the header with
 *              acpi_os_unmap_memory

However, looking at the code, it seems that we are already calling
acpi_os_unmap_memory() internally as appropriate, and we always return
a copy of the header, not a pointer to it. So I see no reason why the
caller would ever need to call acpi_os_unmap_memory(). As a matter of
fact the only current caller of this function does NOT call
acpi_os_unmap_memory() afterwards.

So I believe this note is wrong and should be removed?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
