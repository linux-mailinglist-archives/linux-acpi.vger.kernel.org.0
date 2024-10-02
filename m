Return-Path: <linux-acpi+bounces-8526-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362F98CE5F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 10:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35529B22FA5
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 08:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ADA1946B0;
	Wed,  2 Oct 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SECLJeJs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65E194A74
	for <linux-acpi@vger.kernel.org>; Wed,  2 Oct 2024 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856503; cv=none; b=c2uKwgic1LZCjAa22STXWRBiCamKJ1Tva+g1a0qb9LiMVATKEYTZ54JIXJV+ng5MJtvdoVnzYNbk1acJVIf0MKcNH5w/+JacQM4AUrFwZyp/CcwvWz21oSZ37kbFpnIvoM0FH5elHOrgkCscC6PlMzwP0Vi8enyY3b9A3CQgzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856503; c=relaxed/simple;
	bh=aj2o+qVPkCK89hmPXymzEaqlhsQ+Ok5bYC/dohwnc5w=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ojmgPYkSk4vIn52/xXOU7GQ4U0mqWRKXfuBs80q85n1wYur4TnCfqi3LSW+KG1MYNuDqHtORIyJtzwJdWUbRlSKcDfNiod4ZaI0p57mW84Ao8WS2k3NX2fsVMEV2EXQWegERuINatQnXJaOXd6PtLgFMA1ykKTDlJPoXLWqY7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SECLJeJs; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727856497; x=1728461297; i=w_armin@gmx.de;
	bh=aj2o+qVPkCK89hmPXymzEaqlhsQ+Ok5bYC/dohwnc5w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SECLJeJs8pRlAMw04ONz0WrJ9bEdp+NCIpvoLL/Rd3xqYIUJQM+ydCoQnpPUIThp
	 FvKRZvQB231PuVWpLaje8FTFU4W4m6iYnuXXYFbZyS0sBXyKoZxycfwQTcPSJv1ca
	 7QrCUoHqlRfucfNxScUAFiJ0nPsNwa94SHwRUU8SHqm7vTGMIZZkXRbjN0ItF9kK0
	 BM+2GKb/lF0gKR76qZQk6RuXeitiNzwIR03rBTkkfnDauxMVTDxF2Nr9Y+pKffw8X
	 H7OJRLSEZjcQgd2W8OLuwk6lY0lO889hJ8QxSnEgbuJ5J7UfNSpsmsEsfpnXBnaTN
	 nAH4MJNHlHqgaI8Odg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1sFONr3JE6-00bteC for
 <linux-acpi@vger.kernel.org>; Wed, 02 Oct 2024 10:08:17 +0200
Message-ID: <6274fdb7-ba80-4c34-94c8-04b7ff29a8c9@gmx.de>
Date: Wed, 2 Oct 2024 10:08:17 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-acpi@vger.kernel.org
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
Subject: s2idle issue on Dell G51 5155
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wO6hxmSxlMVjpK78JacnQrQWovBZSZjAvydiYcignP0JK7SRfss
 pmPbP6D7BRR4IoGummn+TJQJn3kzVZWSvF32tbn7L8FWCh1c/idJtrcif/22aPQl8nRPuYa
 ny0BkONXkR1zEvoNoFQeHHVc6U9QTwcvtieNgT0orUGTNCmitL8U30tT3lQ9uy3/THcNwqZ
 2+4r5+kqOpvZppOU4kPEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eeAz5c2Nv/A=;yaHNjXSrgg8JRJxHtXT6Be0+S6G
 2YFLMeH5sqpFdIuYSd/4emyy+B8QpHdRIad0WCTc1iS12cbQb/xitJaG77tmnghzNfTopL0dW
 lqLeJdeyV60aLvZQ2tBccW1rgXAs4wAS/bKJb3vbaDy1kHO4Sw3+jPH1p410rJaqZLyzuUgKI
 ApS3UIFYRzfQyFk05KX1KkM61GP5i5FZRdqKFUkh1NCHfzqUHl9ozTXEyjqJv+Gh7LuupnMKZ
 2WiYNFNp+wMX3SfFrwQY/YnWrbfKG2icdwbTlXZetTy7KwGfZ6KyKrhDo/y4kIbprcduQgw8K
 64jr63rb1Rdq6IKv9PsfmolK6ODFG5fyXdThHzCc8EHW6sKZiUz6b8iTqHF8wmxp682hFpvdQ
 Ok7QAo4RQTGwdsqy/NouUxBKIXzeB1oetT5dT/BevRY1Y3ZwI09Ix0biuUETzgmMHdTjwX9wY
 q1hp0l0co/ujK/NPU+RftQBu0n7lIVnDVWApILvxNqo/nnyd/l054W96EcivRbbf2l3GCpeHA
 Ob4vZ8/UQU2mo3DuXnRLSscD+ycMUyqR0ZjMvEYYQ4iv+YS2WoXm1V71r50LKkqpF4VL5Wc7m
 8/UeBMTYfidMwaL8x0mEEf5qoMc7d5FY8D1RHNDhgTfYQNsxJzlTvGGxuIEyLAPDzw8xIUqcf
 0AqhSa4/tUM5HyK94qAxIWVk/IR4wWNe4FMxL0CjjQx8Stedj70F0jEKMXNKQldCUl+xOtSAs
 a/lWjpAZYJCvbnrNl1hTzjxbinh+CueV/RZ5k7nUczfLGhAg+OvLMzae6/9/e7ebCG6uhpEhO
 rojGeRDh6evjMq4QORsf6HxddaIGdXVy0pbOdpQDY3TUQ=

Hello,

it seems a user has problems suspending its Dell G51 5155 using s2idle, see
https://bugzilla.kernel.org/show_bug.cgi?id=218337 for details.

Does anyone have an idea on how to debug this?

Thanks,
Armin Wolf


