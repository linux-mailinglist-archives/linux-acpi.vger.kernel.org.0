Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA2BA44D6E
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 22:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfFMU3K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 16:29:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44502 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfFMU3K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jun 2019 16:29:10 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 378a2532ed87e9db; Thu, 13 Jun 2019 22:29:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Qian Cai <cai@lca.pw>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi/osl: fix a W=1 kernel-doc warning
Date:   Thu, 13 Jun 2019 22:29:07 +0200
Message-ID: <6868629.n82pnhf9I3@kreacher>
In-Reply-To: <1559593715-29599-1-git-send-email-cai@lca.pw>
References: <1559593715-29599-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, June 3, 2019 10:28:35 PM CEST Qian Cai wrote:
> It appears that kernel-doc does not understand the return type *__ref,
> 
> drivers/acpi/osl.c:306: warning: cannot understand function prototype:
> 'void __iomem *__ref acpi_os_map_iomem(acpi_physical_address phys,
> acpi_size size)
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/acpi/osl.c     | 4 ++--
>  include/acpi/acpi_io.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index cc7507091dec..9c0edf2fc0dd 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -301,8 +301,8 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
>   * During early init (when acpi_permanent_mmap has not been set yet) this
>   * routine simply calls __acpi_map_table() to get the job done.
>   */
> -void __iomem *__ref
> -acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
> +void __iomem __ref
> +*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
>  {
>  	struct acpi_ioremap *map;
>  	void __iomem *virt;
> diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> index d0633fc1fc15..12d8bd333fe7 100644
> --- a/include/acpi/acpi_io.h
> +++ b/include/acpi/acpi_io.h
> @@ -16,8 +16,8 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>  
>  extern bool acpi_permanent_mmap;
>  
> -void __iomem *__ref
> -acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
> +void __iomem __ref
> +*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
>  void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size);
>  void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size);
>  
> 

Applied, thanks!




