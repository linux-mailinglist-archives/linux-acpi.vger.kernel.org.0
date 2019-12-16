Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC21203D4
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 12:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfLPLY7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 06:24:59 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42198 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfLPLY7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 06:24:59 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id a75c78bdd54642d0; Mon, 16 Dec 2019 12:24:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] tools/acpi: fix compilation error
Date:   Mon, 16 Dec 2019 12:24:57 +0100
Message-ID: <3122906.rUR3b5QzkR@kreacher>
In-Reply-To: <20191213162712.6208-1-liuzhengyuan@kylinos.cn>
References: <20191213162712.6208-1-liuzhengyuan@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, December 13, 2019 5:27:12 PM CET Zhengyuan Liu wrote:
> If we compile tools/acpi target in the top source directory, we'd get a
> compilation error showing as bellow:
> 
> 	# make tools/acpi
> 	  DESCEND  power/acpi
> 	  DESCEND  tools/acpidbg
> 	  CC       tools/acpidbg/acpidbg.o
> 	Assembler messages:
> 	Fatal error: can't create /home/lzy/kernel-upstream/power/acpi/\
> 			tools/acpidbg/acpidbg.o: No such file or directory
> 	../../Makefile.rules:26: recipe for target '/home/lzy/kernel-upstream/\
> 			power/acpi/tools/acpidbg/acpidbg.o' failed
> 	make[3]: *** [/home/lzy/kernel-upstream//power/acpi/tools/acpidbg/\
> 			acpidbg.o] Error 1
> 	Makefile:19: recipe for target 'acpidbg' failed
> 	make[2]: *** [acpidbg] Error 2
> 	Makefile:54: recipe for target 'acpi' failed
> 	make[1]: *** [acpi] Error 2
> 	Makefile:1607: recipe for target 'tools/acpi' failed
> 	make: *** [tools/acpi] Error 2
> 
> Fixes: d5a4b1a540b ("tools/power/acpi: Remove direct kernel source include reference")
> Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
> ---
>  tools/power/acpi/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
> index 0111d246d1ca..54a2857c2510 100644
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -15,7 +15,7 @@ include $(srctree)/../../scripts/Makefile.include
>  
>  OUTPUT=$(srctree)/
>  ifeq ("$(origin O)", "command line")
> -	OUTPUT := $(O)/power/acpi/
> +	OUTPUT := $(O)/tools/power/acpi/
>  endif
>  #$(info Determined 'OUTPUT' to be $(OUTPUT))
>  
> 

Applying as 5.6 material, thanks!




