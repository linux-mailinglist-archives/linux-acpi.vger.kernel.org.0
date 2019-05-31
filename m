Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF4530B66
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfEaJYv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 05:24:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62473 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaJYv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 May 2019 05:24:51 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 639ee21c405379e7; Fri, 31 May 2019 11:24:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Erik Schmauss <erik.schmauss@intel.com>, devel@acpica.org
Subject: Re: [PATCH v2] tools/power/acpi: exclude tools/* from .gitignore pattern
Date:   Fri, 31 May 2019 11:24:47 +0200
Message-ID: <67810452.HO43NzBsMe@kreacher>
In-Reply-To: <1556718785-4417-1-git-send-email-yamada.masahiro@socionext.com>
References: <1556718785-4417-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, May 1, 2019 3:53:05 PM CEST Masahiro Yamada wrote:
> tools/power/acpi/.gitignore has the following entries:
> 
>   acpidbg
>   acpidump
>   ec
> 
> They are intended to ignore the following build artifacts:
> 
>   tools/power/acpi/acpidbg
>   tools/power/acpi/acpidump
>   tools/power/acpi/ec
> 
> However, those .gitignore entries are effective not only for the
> current directory, but also for any sub-directories.
> 
> So, from the point of .gitignore grammar, the following check-in
> directories are also considered to be ignored:
> 
>   tools/power/acpi/tools/acpidbg
>   tools/power/acpi/tools/acpidump
>   tools/power/acpi/tools/ec
> 
> As the manual gitignore(5) says "Files already tracked by Git are not
> affected", this is not a problem as far as Git is concerned.
> 
> However, Git is not the only program that parses .gitignore because
> .gitignore is useful to distinguish build artifacts from source files.
> 
> For example, tar(1) supports the --exclude-vcs-ignore option. As of
> writing, this option does not work perfectly, but it intends to create
> a tarball excluding files specified by .gitignore.
> 
> So, I believe it is better to fix this issue.
> 
> You can fix it by prefixing the pattern with a slash; the leading slash
> means the specified pattern is relative to the current directory.
> 
> I also prefixed the "include" consistently. IMHO, it is safer when you
> intend to ignore specific files or directories.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Add more information to the commit log to clarify my main motivation
> 
>  tools/power/acpi/.gitignore | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/power/acpi/.gitignore b/tools/power/acpi/.gitignore
> index cba3d99..f698a0e 100644
> --- a/tools/power/acpi/.gitignore
> +++ b/tools/power/acpi/.gitignore
> @@ -1,4 +1,4 @@
> -acpidbg
> -acpidump
> -ec
> -include
> +/acpidbg
> +/acpidump
> +/ec
> +/include/
> 

I actually have applied this one, not the v1, sorry for the confusion.




