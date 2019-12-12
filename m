Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0199111D8FD
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2019 23:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfLLWAj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 17:00:39 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63835 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbfLLWAj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Dec 2019 17:00:39 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 1f2ddddf726fb963; Thu, 12 Dec 2019 23:00:36 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     rafael.j.wysocki@intel.com, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, lv.zheng@intel.com
Subject: Re: [PATCH] tools/acpi: fix compilation error
Date:   Thu, 12 Dec 2019 23:00:36 +0100
Message-ID: <12331560.QE9YiZyXd8@kreacher>
In-Reply-To: <1574167929-11244-1-git-send-email-liuzhengyuan@kylinos.cn>
References: <1574167929-11244-1-git-send-email-liuzhengyuan@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, November 19, 2019 1:52:09 PM CET Zhengyuan Liu wrote:
> From: liuzhengyuan <liuzhengyuan@kylinos.com.cn>
> 
> If we compile tools/acpi target in the top source directory, we'd get a
> compilation error showing as bellow:
> 
> 	# make tools/acpi
> 	  DESCEND  power/acpi
> 	  DESCEND  tools/acpidbg
> 	  CC       tools/acpidbg/acpidbg.o
> 	Assembler messages:
> 	Fatal error: can't create /home/lzy/kernel-upstream/linux-linus-ubuntu/power\
> 			/acpi/tools/acpidbg/acpidbg.o: No such file or directory
> 	../../Makefile.rules:26: recipe for target '/home/lzy/kernel-upstream/linux-\
> 			linus-ubuntu/power/acpi/tools/acpidbg/acpidbg.o' failed
> 	make[3]: *** [/home/lzy/kernel-upstream/linux-linus-ubuntu/power/acpi/tools/\
> 			acpidbg/acpidbg.o] Error 1
> 	Makefile:19: recipe for target 'acpidbg' failed
> 	make[2]: *** [acpidbg] Error 2
> 	Makefile:54: recipe for target 'acpi' failed
> 	make[1]: *** [acpi] Error 2
> 	Makefile:1607: recipe for target 'tools/acpi' failed
> 	make: *** [tools/acpi] Error 2
> 
> Fixes: d5a4b1a540b ("tools/power/acpi: Remove direct kernel source include reference")
> Signed-off-by: liuzhengyuan <liuzhengyuan@kylinos.com.cn>

You evidently could use the proper English spelling of your full name when
sending the message, so what would be wrong with using it for the sign-off too?

> ---
>  tools/power/acpi/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
> index 0111d24..54a2857 100644
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




