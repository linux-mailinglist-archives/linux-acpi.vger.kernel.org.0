Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E31B3BB7
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Apr 2020 11:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgDVJsg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 22 Apr 2020 05:48:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44594 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgDVJsf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Apr 2020 05:48:35 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id e858c47feeb885bf; Wed, 22 Apr 2020 11:48:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] pnp: Use list_for_each_entry() instead of open coding
Date:   Wed, 22 Apr 2020 11:48:32 +0200
Message-ID: <4331726.1SaVFhkE9D@kreacher>
In-Reply-To: <0-v1-f68011aff1f8+d8-pnp_gcc10%jgg@mellanox.com>
References: <0-v1-f68011aff1f8+d8-pnp_gcc10%jgg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, April 14, 2020 5:10:50 PM CEST Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Aside from good practice, this avoids a warning from gcc 10:
> 
> ./include/linux/kernel.h:997:3: warning: array subscript -31 is outside array bounds of ‘struct list_head[1]’ [-Warray-bounds]
>   997 |  ((type *)(__mptr - offsetof(type, member))); })
>       |  ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/list.h:493:2: note: in expansion of macro ‘container_of’
>   493 |  container_of(ptr, type, member)
>       |  ^~~~~~~~~~~~
> ./include/linux/pnp.h:275:30: note: in expansion of macro ‘list_entry’
>   275 | #define global_to_pnp_dev(n) list_entry(n, struct pnp_dev, global_list)
>       |                              ^~~~~~~~~~
> ./include/linux/pnp.h:281:11: note: in expansion of macro ‘global_to_pnp_dev’
>   281 |  (dev) != global_to_pnp_dev(&pnp_global); \
>       |           ^~~~~~~~~~~~~~~~~
> arch/x86/kernel/rtc.c:189:2: note: in expansion of macro ‘pnp_for_each_dev’
>   189 |  pnp_for_each_dev(dev) {
> 
> Because the common code doesn't cast the starting list_head to the
> containing struct.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  include/linux/pnp.h | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> Compile tested only
> 
> (resent with mailing list in cc, sorry)
> 
> diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> index b18dca67253d66..db41156b1b4044 100644
> --- a/include/linux/pnp.h
> +++ b/include/linux/pnp.h
> @@ -220,10 +220,8 @@ struct pnp_card {
>  #define global_to_pnp_card(n) list_entry(n, struct pnp_card, global_list)
>  #define protocol_to_pnp_card(n) list_entry(n, struct pnp_card, protocol_list)
>  #define to_pnp_card(n) container_of(n, struct pnp_card, dev)
> -#define pnp_for_each_card(card) \
> -	for((card) = global_to_pnp_card(pnp_cards.next); \
> -	(card) != global_to_pnp_card(&pnp_cards); \
> -	(card) = global_to_pnp_card((card)->global_list.next))
> +#define pnp_for_each_card(card)                                                \
> +	list_for_each_entry(card, &pnp_cards, global_list)
>  
>  struct pnp_card_link {
>  	struct pnp_card *card;
> @@ -276,14 +274,9 @@ struct pnp_dev {
>  #define card_to_pnp_dev(n) list_entry(n, struct pnp_dev, card_list)
>  #define protocol_to_pnp_dev(n) list_entry(n, struct pnp_dev, protocol_list)
>  #define	to_pnp_dev(n) container_of(n, struct pnp_dev, dev)
> -#define pnp_for_each_dev(dev) \
> -	for((dev) = global_to_pnp_dev(pnp_global.next); \
> -	(dev) != global_to_pnp_dev(&pnp_global); \
> -	(dev) = global_to_pnp_dev((dev)->global_list.next))
> -#define card_for_each_dev(card,dev) \
> -	for((dev) = card_to_pnp_dev((card)->devices.next); \
> -	(dev) != card_to_pnp_dev(&(card)->devices); \
> -	(dev) = card_to_pnp_dev((dev)->card_list.next))
> +#define pnp_for_each_dev(dev) list_for_each_entry(dev, &pnp_global, global_list)
> +#define card_for_each_dev(card, dev)                                           \
> +	list_for_each_entry(dev, &(card)->devices, card_list)
>  #define pnp_dev_name(dev) (dev)->name
>  
>  static inline void *pnp_get_drvdata(struct pnp_dev *pdev)
> @@ -437,14 +430,10 @@ struct pnp_protocol {
>  };
>  
>  #define to_pnp_protocol(n) list_entry(n, struct pnp_protocol, protocol_list)
> -#define protocol_for_each_card(protocol,card) \
> -	for((card) = protocol_to_pnp_card((protocol)->cards.next); \
> -	(card) != protocol_to_pnp_card(&(protocol)->cards); \
> -	(card) = protocol_to_pnp_card((card)->protocol_list.next))
> -#define protocol_for_each_dev(protocol,dev) \
> -	for((dev) = protocol_to_pnp_dev((protocol)->devices.next); \
> -	(dev) != protocol_to_pnp_dev(&(protocol)->devices); \
> -	(dev) = protocol_to_pnp_dev((dev)->protocol_list.next))
> +#define protocol_for_each_card(protocol, card)                                 \
> +	list_for_each_entry(card, &(protocol)->cards, protocol_list)
> +#define protocol_for_each_dev(protocol, dev)                                   \
> +	list_for_each_entry(dev, &(protocol)->devices, protocol_list)
>  
>  extern struct bus_type pnp_bus_type;

Applied with some minor white space changes, as 5.7-rc material.

Thanks!



