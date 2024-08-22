Return-Path: <linux-acpi+bounces-7772-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2548095B09E
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 10:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB7E1F25DB6
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3456017C213;
	Thu, 22 Aug 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jevklidu.cz header.i=petr@jevklidu.cz header.b="MaBD9W4R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794B17CA03;
	Thu, 22 Aug 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315620; cv=pass; b=meYm4duJTeZRqYYuPo0S8Y7Oeug4R3M5QtoZ6F0dFMGnY0Rjh92itrgtSbCw10l88sblRQJkmcwtO/IGJz64UE6OEVVIeqJx91vxu1FUHkC26mW3HDq+qAFJRfMmbEts5qVTPHv8B6WMwuiMWhDlgGae8MOxBJAS4G8cCPnzugA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315620; c=relaxed/simple;
	bh=hHGCUtUaTPhxfLgE4Cw9O/MYQqKVunKbuzQC3CfdY30=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uj2ch2anzP1uoZd/FrFCbhuQXzQZs3BUOHmmuFlVMIVhTdinEE2iMyycSr4FSQer87w5Yq3TKodpVAkS33BG54Mq4DNpCaAwz8TKbb1QFmSOI1cP24hRTVMJlmWAxFlcnjPalsLKSLX5Xg3+w3tmhbWmV3f0q8DwlFp2I67IhIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jevklidu.cz; spf=pass smtp.mailfrom=jevklidu.cz; dkim=pass (1024-bit key) header.d=jevklidu.cz header.i=petr@jevklidu.cz header.b=MaBD9W4R; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jevklidu.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jevklidu.cz
ARC-Seal: i=1; a=rsa-sha256; t=1724315600; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GhKmdIuSFqdOJgJaC9epo7uH2lPVgIq3sTLjkfwPs/kqbmkeBBu8I95TCw65+HoWUnReQq05jOnIyeQ+8wBBmn/6QZHrs/4b7UujOIv2Oq/EmoJeny8CDMBI0OyyoeCeF0z7HZS9rEH0jXVp6YfUesVb8XFc1IL1RnEdaQswdfc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724315600; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u2xe4iZmScZzyrrYEx2M4UEquQ1gVjFlwQGH+JO6v0Q=; 
	b=HS84Jl9vJhGVoALvm+gDG46WxA3HCWuFlEcYTlN6GMili6yMLhCQLda9/xbjuYGhRI+neZpZEG/7+h4QJt0PCDNV0lEtVBMI1S1n2uoWuBcHi88O5U1Td+gH29FBdPZoUVSRMAwdMqzDII8QHK7Vv7FhljFbc8LHk6qfD7/UAvM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=jevklidu.cz;
	spf=pass  smtp.mailfrom=petr@jevklidu.cz;
	dmarc=pass header.from=<petr@jevklidu.cz>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724315600;
	s=zoho; d=jevklidu.cz; i=petr@jevklidu.cz;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=u2xe4iZmScZzyrrYEx2M4UEquQ1gVjFlwQGH+JO6v0Q=;
	b=MaBD9W4RBcRuyWIzfE0/Tuj6wUwdL1QGqM6nixfeuHxlCscf+vsGRGGGBzxy1fBX
	rzUY53xEJGlyUZ8Fuka668Z7+lYzd0FEBQVsKbir00Gfo+Rl3cgSjN/1EEcNABysqmF
	k1coBVu0N9hGE10rsTis9rWWWVPFhZWLk3EMurnU=
Received: by mx.zohomail.com with SMTPS id 1724315598622873.846586922534;
	Thu, 22 Aug 2024 01:33:18 -0700 (PDT)
Message-ID: <5bba930f-4c32-401c-a2e0-80dbad36487a@jevklidu.cz>
Date: Thu, 22 Aug 2024 10:33:12 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI IRQ storm with 6.10
From: Petr Valenta <petr@jevklidu.cz>
To: Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Hui Wang <hui.wang@canonical.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240821145959.GA248604@bhelgaas>
 <1041b9b5-cc78-13b1-459a-d1d3a313475a@intel.com>
 <5ba3c7c2-5695-421d-a747-2a23af48db26@jevklidu.cz>
Content-Language: cs-CZ
In-Reply-To: <5ba3c7c2-5695-421d-a747-2a23af48db26@jevklidu.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External



Dne 22. 08. 24 v 9:44 Petr Valenta napsal(a):
> 
> 
> Dne 21. 08. 24 v 17:17 Vitaly Lifshits napsal(a):
>>
>> On 8/21/2024 5:59 PM, Bjorn Helgaas wrote:
>>> [+to Dima, Vitaly, Hui; beginning of thread at
>>> https://lore.kernel.org/r/60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org]
>>>
>>> On Wed, Aug 21, 2024 at 01:39:11PM +0200, Petr Valenta wrote:
>>>> Dne 20. 08. 24 v 23:30 Bjorn Helgaas napsal(a):
>>>>> On Tue, Aug 20, 2024 at 11:13:54PM +0200, Petr Valenta wrote:
>>>>>> Dne 20. 08. 24 v 20:09 Bjorn Helgaas napsal(a):
>>>>>>> On Mon, Aug 19, 2024 at 07:23:42AM +0200, Jiri Slaby wrote:
>>>>>>>> On 19. 08. 24, 6:50, Jiri Slaby wrote:
>>>>>>>>> CC e1000e guys + Jesse (due to 75a3f93b5383) + Bjorn (due to 
>>>>>>>>> b2c289415b2b)
>>>> ...
>>>>> I'm at a loss.  You could try reverting the entire b2c289415b2b commit
>>>>> (patch for that is below).
>>>> This patch didn't help, so I reverted it back.
>>>>
>>>>> If that doesn't help, I guess you could try reverting the other
>>>>> commits Jiri mentioned:
>>>>>
>>>>>     76a0a3f9cc2f e1000e: fix force smbus during suspend flow
>>>>>     c93a6f62cb1b e1000e: Fix S0ix residency on corporate systems
>>>>>     bfd546a552e1 e1000e: move force SMBUS near the end of 
>>>>> enable_ulp function
>>>>>     6918107e2540 net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD 
>>>>> duplicates
>>>>>     1eb2cded45b3 net: annotate writes on dev->mtu from 
>>>>> ndo_change_mtu()
>>>>>     b2c289415b2b e1000e: Remove redundant runtime resume for 
>>>>> ethtool_ops
>>>>>     75a3f93b5383 net: intel: implement modern PM ops declarations
>>>>>
>>>>> If you do this, I would revert 76a0a3f9cc2f, test, then revert
>>>>> c93a6f62cb1b in addition, test, then revert bfd546a552e1 in addition,
>>>>> etc.
>>>> I have created revert patches like this:
>>>> git format-patch --stdout -1 76a0a3f9cc2f | interdiff -q /dev/stdin \
>>>> /dev/null > revert_76a0a3f9cc2f.patch
>>>>
>>>> I have applied revert_76a0a3f9cc2f.patch (rebuild and tested), then in
>>>> addition revert_c93a6f62cb1b.patch and after applying
>>>> revert_bfd546a552e1.patch irq storm didn't appear.
>>>>
>>>> I have tested it with 3 subsequent reboots and in all those cases it 
>>>> was ok.
>>> Thanks for all this testing.  It sounds like reverting all three of
>>> 76a0a3f9cc2f, c93a6f62cb1b, and bfd546a552e1 fixed the IRQ storm, but
>>> I'm not clear on the results of other situations.
>>>
>>> It looks like c93a6f62cb1b could be reverted by itself because it's
>>> unrelated to 76a0a3f9cc2f and bfd546a552e1.  I added the authors of
>>> all three in case they have any insights.
>>>
>>> Bjorn
>>
>>
>> I doubt that it is related to c93a6f62cb1b, I believe that is more 
>> probable to be related to the two other patches.
>>
>> Apart from what I suggested in the other mailing thread (enabling 
>> e1000e debug and to test if it happens with a cable connected),
>>
>> I suggest to try to apply this patch and see if it fixes the issue:
>>
>> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20240806132348.880744-1-vitaly.lifshits@intel.com/
> 
> I have applied patch from link above and command bellow really doesn't 
> start irq storm.
> 
> echo 'auto' > /sys/bus/pci/devices/0000:00:1f.6/power/control
> 
> Problem is that after executing this command and plugging cable to 
> ethernet port, kernel is not able to detect link (LED indicate link is 
> on) so network over cable is not working.
> 
>>
>>
> 
>  From mboxrd@z Thu Jan  1 00:00:00 1970
> Return-Path: <intel-wired-lan-bounces@osuosl.org>
> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
>      aws-us-west-2-korg-lkml-1.web.codeaurora.org
> Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
>      (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
>      (No client certificate requested)
>      by smtp.lore.kernel.org (Postfix) with ESMTPS id 7319CC531DF
>      for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Aug 2024 
> 07:44:59 +0000 (UTC)
> Received: from localhost (localhost [127.0.0.1])
>      by smtp2.osuosl.org (Postfix) with ESMTP id 2EE99404B8;
>      Thu, 22 Aug 2024 07:44:59 +0000 (UTC)
> X-Virus-Scanned: amavis at osuosl.org
> Received: from smtp2.osuosl.org ([127.0.0.1])
> by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
> id VRgkrPDlq_WW; Thu, 22 Aug 2024 07:44:56 +0000 (UTC)
> X-Comment: SPF check N/A for local connections - 
> client-ip=140.211.166.34; helo=ash.osuosl.org; 
> envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
> DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53F64405BA
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
>      s=default; t=1724312696;
>      bh=y3v3IIFARTszfLWu7n/j8Du29EOi4VTxMDP3GF4qp7E=;
>      h=Date:To:References:From:In-Reply-To:Subject:List-Id:
>       List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
>       Cc:From;
>      b=ZIudOsHGSDoQvtekseiE4SUpOKofnvHlxj7aT3f7bLvqCDMOCfygsO6tctN23YgSh
>       xYqnq4yBSB4/JQ4v7Juyg0P/wqTcr+XFqhORTc2qBku9GCA+Y4wRKbRUeH4/AUNthL
>       cf/zG7uEOFEKz4YALwviQFqR5E+HW9gD+YnXahtGUVqYiTjB01HuESDZdYI5huiCLI
>       eHnQDw/SSwM1YmkjLzQgICjlxtIRVYjUL+shaltRg9f7t4otZa9bvrvLptzw5Mrfc0
>       GLvrNRmHckPFKEJOXgmIeQI40IOHckD3MX2dkQ2dQ0VCrkl9JIgtuSRuS3IpB1dr65
>       TatTrq9Onm26w==
> Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
>      by smtp2.osuosl.org (Postfix) with ESMTP id 53F64405BA;
>      Thu, 22 Aug 2024 07:44:56 +0000 (UTC)
> Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
> by ash.osuosl.org (Postfix) with ESMTP id 81E351BF322
> for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 07:44:54 +0000 
> (UTC)
> Received: from localhost (localhost [127.0.0.1])
> by smtp1.osuosl.org (Postfix) with ESMTP id 79A0C80A82
> for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 07:44:54 +0000 
> (UTC)
> X-Virus-Scanned: amavis at osuosl.org
> Received: from smtp1.osuosl.org ([127.0.0.1])
> by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
> id m9sJJpu9kR7y for <intel-wired-lan@lists.osuosl.org>;
> Thu, 22 Aug 2024 07:44:53 +0000 (UTC)
> Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.52;
> helo=sender4-of-o52.zoho.com; envelope-from=petr@jevklidu.cz;
> receiver=<UNKNOWN> DMARC-Filter: OpenDMARC Filter v1.4.2 
> smtp1.osuosl.org 3674B80A59
> DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3674B80A59
> Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com
> [136.143.188.52])
> by smtp1.osuosl.org (Postfix) with ESMTPS id 3674B80A59
> for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 07:44:51 +0000 
> (UTC)
> ARC-Seal: i=1; a=rsa-sha256; t=1724312671; cv=none; d=zohomail.com; 
> s=zohoarc; 
> b=B0wnUG3UHEcTRfbjC9HSfLJG+WBnpU18yag7r0240QuMQMnP/cHcj9e4oJU2FgxRPLpt6OGnlZOiPNE2GUFgnkBzKBPwzxb7eTHFwW4P8cW+1IrIOQ6jZWd2rhOIyWcRKYMydfCbMPM04Z+RwKVyRlrLTYL5UDBYYKKHOG08Ikc=
> ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; 
> d=zohomail.com;
> s=zohoarc; t=1724312671;
> h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
> bh=y3v3IIFARTszfLWu7n/j8Du29EOi4VTxMDP3GF4qp7E=; 
> b=VvZAc/xKVy85rZpNNCAwUwpxquk4r4Xw2QjZmePGlnINwOvJf6oilR9lqx2WDMezV20iKTW9f3dauO4jIjp363HOdh7P21UFfa66a0oK63RODo7IQMHSCqaCwAEoO1PKHfDfTMwz0/BShU1dt+nhtAeSeKwbG7G1qizCcoXTdjo=
> ARC-Authentication-Results: i=1; mx.zohomail.com;
> dkim=pass  header.i=jevklidu.cz;
> spf=pass  smtp.mailfrom=petr@jevklidu.cz;
> dmarc=pass header.from=<petr@jevklidu.cz>
> Received: by mx.zohomail.com with SMTPS id 1724312669862808.3168476405893;
> Thu, 22 Aug 2024 00:44:29 -0700 (PDT)
> Message-ID: <5ba3c7c2-5695-421d-a747-2a23af48db26@jevklidu.cz>
> Date: Thu, 22 Aug 2024 09:44:22 +0200
> MIME-Version: 1.0
> User-Agent: Mozilla Thunderbird
> To: Vitaly Lifshits <vitaly.lifshits@intel.com>,
> Bjorn Helgaas <helgaas@kernel.org>, Dima Ruinskiy 
> <dima.ruinskiy@intel.com>,
> Hui Wang <hui.wang@canonical.com>
> References: <20240821145959.GA248604@bhelgaas>
> <1041b9b5-cc78-13b1-459a-d1d3a313475a@intel.com>
> Content-Language: cs-CZ, en-US
> From: Petr Valenta <petr@jevklidu.cz>
> In-Reply-To: <1041b9b5-cc78-13b1-459a-d1d3a313475a@intel.com>
> Content-Type: text/plain; charset=UTF-8; format=flowed
> Content-Transfer-Encoding: 7bit
> X-ZohoMailClient: External
> X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
> c=relaxed/relaxed; t=1724312671; s=zoho; d=jevklidu.cz; i=petr@jevklidu.cz;
> h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
> bh=y3v3IIFARTszfLWu7n/j8Du29EOi4VTxMDP3GF4qp7E=;
> b=RSnIQpqoQp2O3ExJNnw4fk9dlt8CX1T5sbtB6GflBDYejiRQJTcrU3zRHn3pRkFq
> tm00/cgXr6pF6T5vJFttBkfrHtnRiPiE8cjqni5KsNxCyOXOwri6I5ARAmPcUj42eda
> e/xHQX9E3ayXrWSBQDAsun3Ann63tcXQKwlT7ffI=
> X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
> dmarc=none (p=none dis=none)
> header.from=jevklidu.cz
> X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
> dkim=pass (1024-bit key,
> unprotected) header.d=jevklidu.cz header.i=petr@jevklidu.cz
> header.a=rsa-sha256 header.s=zoho header.b=RSnIQpqo
> Subject: Re: [Intel-wired-lan] ACPI IRQ storm with 6.10
> X-BeenThere: intel-wired-lan@osuosl.org
> X-Mailman-Version: 2.1.29
> Precedence: list
> List-Id: Intel Wired Ethernet Linux Kernel Driver Development
> <intel-wired-lan.osuosl.org>
> List-Unsubscribe: 
> <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
> <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
> List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
> List-Post: <mailto:intel-wired-lan@osuosl.org>
> List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
> List-Subscribe: 
> <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
> <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
> "Rafael J. Wysocki" <rafael@kernel.org>, przemyslaw.kitszel@intel.com,
> Linux kernel mailing list <linux-kernel@vger.kernel.org>,
> "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
> Tony Nguyen <anthony.l.nguyen@intel.com>, Bjorn Helgaas 
> <bhelgaas@google.com>,
> intel-wired-lan@lists.osuosl.org, Jiri Slaby <jirislaby@kernel.org>,
> Len Brown <lenb@kernel.org>
> Errors-To: intel-wired-lan-bounces@osuosl.org
> Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
> 
> 
> 
> Dne 21. 08. 24 v 17:17 Vitaly Lifshits napsal(a):
>>
>> On 8/21/2024 5:59 PM, Bjorn Helgaas wrote:
>>> [+to Dima, Vitaly, Hui; beginning of thread at
>>> https://lore.kernel.org/r/60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org]
>>>
>>> On Wed, Aug 21, 2024 at 01:39:11PM +0200, Petr Valenta wrote:
>>>> Dne 20. 08. 24 v 23:30 Bjorn Helgaas napsal(a):
>>>>> On Tue, Aug 20, 2024 at 11:13:54PM +0200, Petr Valenta wrote:
>>>>>> Dne 20. 08. 24 v 20:09 Bjorn Helgaas napsal(a):
>>>>>>> On Mon, Aug 19, 2024 at 07:23:42AM +0200, Jiri Slaby wrote:
>>>>>>>> On 19. 08. 24, 6:50, Jiri Slaby wrote:
>>>>>>>>> CC e1000e guys + Jesse (due to 75a3f93b5383) + Bjorn (due to 
>>>>>>>>> b2c289415b2b)
>>>> ...
>>>>> I'm at a loss.  You could try reverting the entire b2c289415b2b commit
>>>>> (patch for that is below).
>>>> This patch didn't help, so I reverted it back.
>>>>
>>>>> If that doesn't help, I guess you could try reverting the other
>>>>> commits Jiri mentioned:
>>>>>
>>>>>     76a0a3f9cc2f e1000e: fix force smbus during suspend flow
>>>>>     c93a6f62cb1b e1000e: Fix S0ix residency on corporate systems
>>>>>     bfd546a552e1 e1000e: move force SMBUS near the end of 
>>>>> enable_ulp function
>>>>>     6918107e2540 net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD 
>>>>> duplicates
>>>>>     1eb2cded45b3 net: annotate writes on dev->mtu from 
>>>>> ndo_change_mtu()
>>>>>     b2c289415b2b e1000e: Remove redundant runtime resume for 
>>>>> ethtool_ops
>>>>>     75a3f93b5383 net: intel: implement modern PM ops declarations
>>>>>
>>>>> If you do this, I would revert 76a0a3f9cc2f, test, then revert
>>>>> c93a6f62cb1b in addition, test, then revert bfd546a552e1 in addition,
>>>>> etc.
>>>> I have created revert patches like this:
>>>> git format-patch --stdout -1 76a0a3f9cc2f | interdiff -q /dev/stdin \
>>>> /dev/null > revert_76a0a3f9cc2f.patch
>>>>
>>>> I have applied revert_76a0a3f9cc2f.patch (rebuild and tested), then in
>>>> addition revert_c93a6f62cb1b.patch and after applying
>>>> revert_bfd546a552e1.patch irq storm didn't appear.
>>>>
>>>> I have tested it with 3 subsequent reboots and in all those cases it 
>>>> was ok.
>>> Thanks for all this testing.  It sounds like reverting all three of
>>> 76a0a3f9cc2f, c93a6f62cb1b, and bfd546a552e1 fixed the IRQ storm, but
>>> I'm not clear on the results of other situations.
>>>
>>> It looks like c93a6f62cb1b could be reverted by itself because it's
>>> unrelated to 76a0a3f9cc2f and bfd546a552e1.  I added the authors of
>>> all three in case they have any insights.
>>>
>>> Bjorn
>>
>>
>> I doubt that it is related to c93a6f62cb1b, I believe that is more 
>> probable to be related to the two other patches.
>>
>> Apart from what I suggested in the other mailing thread (enabling 
>> e1000e debug and to test if it happens with a cable connected),
>>
>> I suggest to try to apply this patch and see if it fixes the issue:
>>
>> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20240806132348.880744-1-vitaly.lifshits@intel.com/
> 
> I have applied patch from link above and command bellow really doesn't 
> start irq storm.
> 
> echo 'auto' > /sys/bus/pci/devices/0000:00:1f.6/power/control
> 
> Problem is that after executing this command and plugging cable to 
> ethernet port, kernel is not able to detect link (LED indicate link is 
> on) so network over cable is not working.
> 

I have tested now how it behaves with kernel 6.9.9. There is a new 
finding. After running "echo 'auto' > 
/sys/bus/pci/devices/0000:00:1f.6/power/control" network over cable 
works but irq storm arrises. I have never tested this before because I 
don't use cable with this laptop at all. After unplugging cable irq 
storm is gone.

A possible workaround would be to turn off power control for the e1000e 
at the kernel level (if is it possible) so that utilities like powertop 
don't cause irq storm or broken network.

>>
>>
> 

